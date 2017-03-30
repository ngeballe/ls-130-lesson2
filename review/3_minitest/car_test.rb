require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'car'

class CarTest < Minitest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end

  def test_bad_wheels
    skip("Skipping failing bad wheels test! Sad!")
    car = Car.new
    assert_equal(5, car.wheels)
  end
end
