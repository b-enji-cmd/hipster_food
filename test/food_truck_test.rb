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
end