require 'minitest/autorun'
require_relative 'list_comparison'

class ListComparisonTest < Minitest::Test
  def setup
    # @list1 = File.readlines('list1.csv')
    # @list2 = File.readlines
    @comparison = Comparison.new('list1.csv', 'list2.csv')
  end

  def test_list1_only
    assert_equal ['Katie Wilson', 'Maria Gonzalez'], @comparison.list1_only
  end

  def test_list2_only
    assert_equal ['Rex Jensen', 'Tyrone Smith', 'Jennifer Washington'], @comparison.list2_only
  end

  def test_overlap
    assert_equal ['Sammy Jones', 'Jessica Chen', 'Frank Adamson'], @comparison.overlap
  end

  def test_either_list
    assert_equal ['Sammy Jones', 'Katie Wilson', 'Jessica Chen', 'Maria Gonzalez', 'Frank Adamson', 'Rex Jensen', 'Tyrone Smith', 'Jennifer Washington'], @comparison.either_list
  end

  def test_list1
    assert_equal ['Sammy Jones', 'Katie Wilson', 'Jessica Chen', 'Maria Gonzalez', 'Frank Adamson'], @comparison.list1
  end

  def test_list2
    assert_equal ['Sammy Jones', 'Jessica Chen', 'Rex Jensen', 'Frank Adamson', 'Tyrone Smith', 'Jennifer Washington'], @comparison.list2
  end
end
