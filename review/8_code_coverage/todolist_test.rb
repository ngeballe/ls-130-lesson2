require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'todolist'

class TodoListTest < Minitest::Test
  def setup
    @todo1 = Todo.new('Buy milk')
    @todo2 = Todo.new('Clean room')
    @todo3 = Todo.new('Go to gym')
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    todo = @list.shift

    assert_equal(@todo1, todo)
    assert(!@list.include?(@todo1))
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    todo = @list.pop

    assert_equal(@todo3, todo)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done_question
    assert_equal(false, @list.done?)

    @todo1.done!
    @todo2.done!
    @todo3.done!

    assert_equal(true, @list.done?)
  end

  def test_raise_add_non_todo_object
    assert_raises(TypeError) { @list.add("A string") }
    assert_raises(TypeError) { @list.add(37) }
    assert_raises(TypeError) { @list.add(['a', 'b', 1, 'e'])}
    assert_raises(TypeError) { @list.add({a: 1, b: 2})}
  end

  def test_shovel
    new_todo = Todo.new('Go to the bank')
    @list << new_todo
    @todos << new_todo

    assert_equal(@todos, @list.to_a)
  end

  def test_add
    new_todo = Todo.new('Go to the grocery store')
    @list.add(new_todo)
    @todos << new_todo

    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_equal(@todo2, @list.item_at(1))

    assert_raises(IndexError) { @list.item_at(100) }
  end

  def test_mark_done_at
    @list.mark_done_at(2)
    assert_equal(true, @todo3.done?)
    assert_equal(false, @todo1.done?)
    assert_equal(false, @todo2.done?)

    assert_raises(IndexError) { @list.mark_done_at(100) }
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_undone_at(100) }
    
    @todo1.done!
    @todo2.done!
    @todo3.done!
    
    @list.mark_undone_at(1)

    assert_equal(true, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end

  def test_done_bang
    @list.done!

    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)

    assert_equal(true, @list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(100) }

    @list.remove_at(1)

    assert_equal([@todo1, @todo3], @list.to_a)
  end

  def test_to_s
    output = <<~OUTPUT.strip
             ---- Today's Todos ----
             [ ] Buy milk
             [ ] Clean room
             [ ] Go to gym
             OUTPUT
    assert_equal(output, @list.to_s)
  end

  def test_to_s_2
    @list.mark_done_at(1)

    output = <<~OUTPUT.strip
             ---- Today's Todos ----
             [ ] Buy milk
             [X] Clean room
             [ ] Go to gym
             OUTPUT
    assert_equal(output, @list.to_s)    
  end

  def test_to_s_with_all_done
    @list.done!

    output = <<~OUTPUT.strip
             ---- Today's Todos ----
             [X] Buy milk
             [X] Clean room
             [X] Go to gym
             OUTPUT
    assert_equal(output, @list.to_s)
  end

  def test_each
    result = []
    @list.each { |todo| result << todo }
    assert_equal([@todo1, @todo2, @todo3], result)
  end

  def test_each_returns_original_list
    assert_same(@list, @list.each { |todo| nil })
  end

  def test_select
    @todo1.done!
    @todo3.done!

    selected_list = @list.select("Tasks I've Finished") { |todo| todo.done? }

    assert_equal("Tasks I've Finished", selected_list.title)
    assert_equal([@todo1, @todo3], selected_list.to_a)
  end

  def test_select_with_default_title
    todo4 = Todo.new('Clean bathroom')
    @list << todo4

    selected_list = @list.select { |todo| todo.title.start_with?('Clean') }

    assert_instance_of TodoList, selected_list
    assert_equal('Selected Todos', selected_list.title)
    assert_equal([@todo2, todo4], selected_list.to_a) 
  end

  def test_all_done
    @todo1.done!
    @todo3.done!

    all_done_list = @list.all_done

    assert_instance_of(TodoList, all_done_list)
    assert_equal([@todo1, @todo3], all_done_list.to_a)
    assert_equal('Done Tasks', all_done_list.title)
  end

  def test_all_not_done
    @todo1.done!

    all_not_done_list = @list.all_not_done

    assert_instance_of(TodoList, all_not_done_list)
    assert_equal([@todo2, @todo3], all_not_done_list.to_a)
    assert_equal('Incomplete Tasks', all_not_done_list.title)
  end

  def test_mark_all_done
    @list.mark_all_done

    assert_equal(true, [@todo1, @todo2, @todo3].all? { |todo| todo.done? })
  end

  def test_mark_all_undone
    @list.mark_all_done
    @list.mark_all_undone

    assert_equal(true, [@todo1, @todo2, @todo3].none?(&:done?))
  end

  def test_include_question
    assert_equal(true, @list.include?(@todo1))
    assert_equal(true, @list.include?(@todo2))
    assert_equal(true, @list.include?(@todo3))
    assert_equal(false, @list.include?("Bob"))
  end

  def test_find_by_title
    assert_same(@todo2, @list.find_by_title('Clean room'))
  end

  def test_mark_done
    @list.mark_done('Go to gym')
    
    assert_equal(true, @todo3.done?)
  end
end
