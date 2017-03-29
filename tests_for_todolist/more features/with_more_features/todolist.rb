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

  # added

  def emergency!
    self.title = title.upcase + "!!!"
    self
  end

  def end_emergency!
    self.title = title[0] + title[1..-1].downcase
    self.title.sub!("!!!", "")
    self
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

  def remove(todo)
    raise IndexError, "Todo not found" unless @todos.include?(todo)
    @todos.delete(todo)
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

  def map
    results = TodoList.new(title)
    each do |todo|
      results << yield(todo)
    end
    results
  end

  def any?
    each do |todo|
      return true if yield(todo)
    end
    false
  end

  def all?
    each do |todo|
      return false unless yield(todo)
    end
    true
  end

  def none?
    each do |todo|
      return false if yield(todo)
    end
    true
  end

  def empty?
    @todos.empty?
  end

  def reject
    results = []
    each do |todo|
      results << todo unless yield(todo)
    end
    results
  end

  def find_by_title(title)
    @todos.detect { |todo| todo.title == title }
  end

  def add_multiple(*todos)
    todos.each do |todo|
      add(todo)
    end
  end

  def concat(new_list)
    new_list.each do |todo|
      add(todo)
    end
    self
  end

  def move_to_top(title)
    todo = find_by_title(title)
    @todos.unshift(remove(todo))
  end

  def move_to_bottom(title)
    todo = find_by_title(title)
    @todos << remove(todo)
  end

  def self.combine_lists(title, *lists)
    raise TypeError, "Title must be a string" unless title.instance_of?(String)
    raise TypeError, "You must enter at least one list" if lists.empty?
    combined = TodoList.new(title)

    lists.each do |list|
      list.each do |todo|
        combined << todo
      end
    end
    
    combined
  end
end
