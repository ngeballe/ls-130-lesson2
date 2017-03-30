class Comparison
  attr_reader :list1, :list2

  def initialize(list1_filename, list2_filename)
    @list1 = File.readlines(list1_filename).map(&:strip)
    @list2 = File.readlines(list2_filename).map(&:strip)
  end

  def list1_only
    @list1 - @list2
  end

  def list2_only
    @list2 - @list1
  end

  def overlap
    @list1.select { |element| @list2.include?(element) }
  end

  def either_list
    @list1 + (@list2 - @list1)
  end
end


# import list 1
# import list 2
# show stats

