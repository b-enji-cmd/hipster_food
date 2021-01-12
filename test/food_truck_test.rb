require './lib/item'
require './lib/food_truck'
require 'minitest/autorun'
require 'pry'
class FoodTruckTest < Minitest::Test
	def setup
		@item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
		@item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
		@food_truck = FoodTruck.new("Rocky Mountain Pies")
	end

	def test_it_is
		assert_instance_of FoodTruck, @food_truck
	end

	def test_it_has_things
		assert_equal "Rocky Mountain Pies", @food_truck.name
		expected = {}
		assert_equal expected, @food_truck.inventory
	end

	def test_it_can_check_stock
		assert_equal 0, @food_truck.check_stock(@item1)
	end

	def test_it_can_stock
		@food_truck.stock(@item1, 30)
		expected = {
			@item1 => 30
		}

		assert_equal expected, @food_truck.inventory
		assert_equal 30, @food_truck.check_stock(@item1)
	end

	def test_it_can_increment_stock
		@food_truck.stock(@item1, 30)
		@food_truck.stock(@item1, 25)
		assert_equal 55, @food_truck.check_stock(@item1)
		@food_truck.stock(@item2, 12)

		expected = {
			@item1 => 55,
			@item2 => 12
		}

		assert_equal expected, @food_truck.inventory
	end

	def test_it_can_calculate_potential_revenue
		@food_truck.stock(@item1, 30)
		@food_truck.stock(@item1, 25)
		@food_truck.stock(@item2, 12)

		assert_equal 236.25, @food_truck.potential_revenue

	end
end