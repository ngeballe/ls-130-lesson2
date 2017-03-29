require 'pry'

require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use!

require_relative 'todolist'

class TodoListTest < MiniTest::Test
  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
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
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    todo = @list.pop
    assert_equal(@todo3, todo)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done_question
    assert_equal(@list.done?, false)
    @todo1.done!
    assert_equal(@list.done?, false)
    @todo2.done!
    assert_equal(@list.done?, false)
    @todo3.done!
    assert_equal(@list.done?, true)
  end

  def test_add_raise_error
    assert_raises(TypeError) { @list.add("A string todo") }
    assert_raises(TypeError) { @list.add(8) }
    assert_raises(TypeError) { @list.add(["an item", "another item"])}
    assert_raises(TypeError) { @list.add([])}
    assert_raises(TypeError) { @list.add([1, 2, 3])}
    assert_raises(TypeError) { @list.add({today: "take out garbage"})}
  end

  def test_shovel
    new_todo = Todo.new("Walk dog")
    @list << new_todo
    @todos << new_todo

    assert_equal(@todos, @list.to_a)
  end

  def test_add_alias
    new_todo = Todo.new("Go to the bank")
    @list.add(new_todo)
    @todos << new_todo

    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_equal(@todo1, @list.item_at(0))
    assert_equal(@todo3, @list.item_at(2))
    assert_raises(IndexError) { @list.item_at(3) }
  end

  def test_mark_done_at
    assert_raises(IndexError) { @list.mark_done_at(5) }

    @list.mark_done_at(1)
    assert_equal(true, @todo2.done?)
    assert_equal(false, @todo1.done?)
    assert_equal(false, @todo3.done?)
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

    assert_equal(false, @list.to_a.include?(@todo2))
    assert_equal(true, @list.to_a.include?(@todo1))
    assert_equal(true, @list.to_a.include?(@todo3))
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_with_one_done
    @list.mark_done_at(2)

    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [X] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_all_done
    @list.done!

    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s) 
  end

  def test_each
    counter = 0

    @list.each do |todo|
      assert_equal(todo, @todos[counter])
      counter += 1
    end

    result = []
    @list.each { |todo| result << todo }
    assert_equal([@todo1, @todo2, @todo3], result)
  end

  def test_each_returns_original_list
    return_value = @list.each { |todo| todo }
    assert_same(return_value, @list)
  end

  def test_select
    @list.mark_done_at(1)
    list = TodoList.new(@list.title)
    list.add(@todo1)
    list.add(@todo3)

    not_done = @list.select { |todo| !todo.done? }

    assert_equal(list.title, @list.title)
    assert_equal(list.to_s, not_done.to_s)
    assert_equal(not_done.instance_of?(TodoList), true)
    assert_equal([@todo1, @todo3], not_done.to_a)
  end
end
