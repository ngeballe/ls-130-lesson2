# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'.freeze
  UNDONE_MARKER = ' '.freeze

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    raise TypeError, "Can only add Todo objects" unless todo.class == Todo

    @todos << todo
  end
  alias_method :<<, :add

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def item_at(idx)
    @todos.fetch(idx)
  end

  def mark_done_at(idx)
    item_at(idx).done!
  end

  def mark_undone_at(idx)
    item_at(idx).undone!
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def done?
    @todos.all?(&:done?)
  end

  def done!
    each(&:done!)
  end

  def remove_at(idx)
    @todos.delete(item_at(idx))
  end

  def to_s
    "---- #{title} ----\n" + @todos.join("\n")
  end

  def to_a
    @todos
  end

  def each
    @todos.each do |todo|
      yield(todo)
    end
    self
  end

  def select(new_list_title = 'Selected Todos')
    selected_list = TodoList.new(new_list_title)
    each do |todo|
      selected_list << todo if yield(todo)
    end
    selected_list
  end

  def find_by_title(title)
    each do |todo|
      return todo if todo.title == title
    end
    nil
  end

  def all_done
    select('Done Tasks', &:done?)
  end

  def all_not_done
    select('Incomplete Tasks') { |todo| !todo.done? }
  end

  def mark_done(title)
    each do |todo|
      if todo.title == title
        todo.done!
        break
      end
    end
  end

  def mark_all_done
    done!
  end

  def mark_all_undone
    each(&:undone!)
  end

  def include?(todo)
    @todos.include?(todo)
  end
end
