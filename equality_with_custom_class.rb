require 'minitest/autorun'

class Car
  attr_accessor :wheels, :name

  def initialize
    @wheels = 4
  end

  def ==(other)
    other.is_a?(Car) && name == other.name
  end
end

class CarTest < MiniTest::Test
  def test_value_equality
    car1 = Car.new
    car2 = Car.new
    fake_car = "Kim"

    car1.name = "Kim"
    car2.name = "Kim"   
    
    assert_equal(car1, car2)
    assert_equal(fake_car, car2)
    # assert_equal(car1, fake_car)
    # assert_same(car1, car2)
  end

  # def test_raise_compare_string_to_car
  #   car1 = Car.new
  #   car1.name = "Kim"

  #   fake_car = "Kim"

  #   assert_raises(NoMethodError) { car1 == fake_car }
  #   assert_raises(NoMethodError) { car1 != fake_car }
  #   assert_raises(NoMethodError) { car1 > fake_car }
  # end

  def test_compare_cars
    car1 = Car.new
    car2 = Car.new
    fake_car = "Kim"

    car1.name = "Kim"
    car2.name = "Kimmy"   
    
    assert_raises(NoMethodError) { car1 > car2 }
  end
end

# class CarTest < MiniTest::Test
#   def setup
#     @car1 = Car.new
#     @car2 = Car.new

#     @car1.name = "Kim"
#     @car2.name = "Kim"    
#   end

#   def test_value_equality
#     assert_equal(@car1, @car2)
#   end

#   def test_object_equality
#     assert_same(@car1, @car2)
#   end
# end
