require 'pry'

class Todo
  DONE_MARKER = 'X'.freeze
  UNDONE_MARKER = ' '.freeze

  attr_accessor :title, :description, :done

  def initialize(title)
    @title = title
    # @description = description
    @done = false
  end

  def done?
    done
  end

  def done!
    self.done = true
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    raise TypeError, "can only add Todo objects" unless todo.instance_of?(Todo)
    @todos << todo
  end
  alias_method :<<, :add

  def to_a
    @todos
  end

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def done?
    @todos.all? { |todo| todo.done? }
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

  def done!
    @todos.each_index { |idx| mark_done_at(idx) }
  end

  def remove_at(idx)
    @todos.delete(item_at(idx))
  end

  def to_s
    result = "---- #{title} ----\n"
    result << @todos.map(&:to_s).join("\n")
    result
  end

  def each
    @todos.each do |todo|
      yield(todo)
    end
    self
  end

  def select
    results = TodoList.new(title)
    each do |todo|
      results << todo if yield(todo)
    end
    results
  end
end
