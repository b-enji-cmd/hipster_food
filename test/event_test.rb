require './lib/item'
require './lib/food_truck'
require './lib/event'
require 'minitest/autorun'
require 'pry'

class EventTest < Minitest::Test
	def setup
		@event = Event.new("South Pearl Street Farmers Market")


		@food_truck1 = FoodTruck.new("Rocky Mountain Pies")
		@item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
		@item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
		@item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
		@item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})


		@food_truck1.stock(@item1, 35)
		@food_truck1.stock(@item2, 7)

		@food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
		@food_truck2.stock(@item4, 50)
		@food_truck2.stock(@item3, 25)

		@food_truck3 = FoodTruck.new("Palisade Peach Shack")
		@food_truck3.stock(@item1, 65)
	end
	
	def test_it_is
		assert_instance_of Event, @event
	end

	def test_it_has_things
		assert_equal "South Pearl Street Farmers Market", @event.name
		assert_equal [], @event.food_trucks
	end

	def test_it_an_add_trucks
		@event.add_food_truck(@food_truck1)
		@event.add_food_truck(@food_truck2)
		@event.add_food_truck(@food_truck3)

		assert_equal [@food_truck1, @food_truck2,@food_truck3], @event.food_trucks
	end

	def test_it_can_get_names
		@event.add_food_truck(@food_truck1)
		@event.add_food_truck(@food_truck2)
		@event.add_food_truck(@food_truck3)
		
		assert_equal ["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"], @event.food_truck_names
	end

	def test_it_can_get_trucks_that_sell_item
		@event.add_food_truck(@food_truck1)
		@event.add_food_truck(@food_truck2)
		@event.add_food_truck(@food_truck3)

		assert_equal [@food_truck1,@food_truck3], @event.food_trucks_that_sell(@item1)
		assert_equal [@food_truck2], @event.food_trucks_that_sell(@item4)
	end

	def test_potential_revenue
		@event.add_food_truck(@food_truck1)
		@event.add_food_truck(@food_truck2)
		@event.add_food_truck(@food_truck3)

		assert_equal 148.75, @food_truck1.potential_revenue
		assert_equal 345.00, @food_truck2.potential_revenue
		assert_equal 243.75, @food_truck3.potential_revenue
	end

	def test_it_can_get_item_names
		@food_truck3.stock(@item3, 10)

		@event.add_food_truck(@food_truck1)
		@event.add_food_truck(@food_truck2)
		@event.add_food_truck(@food_truck3)

		
		assert_equal ["Peach Pie (Slice)", "Apple Pie (Slice)", "Banana Nice Cream", "Peach-Raspberry Nice Cream"], @event.get_item_names
	end

	def test_it_can_sort_items
		@food_truck3.stock(@item3, 10)

		@event.add_food_truck(@food_truck1)
		@event.add_food_truck(@food_truck2)
		@event.add_food_truck(@food_truck3)

		@event.sorted_item_list
		assert_equal ["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"], @event.sorted_item_list
	end

	def test_it_has_total_inventory
		@food_truck3.stock(@item3, 10)

		@event.add_food_truck(@food_truck1)
		@event.add_food_truck(@food_truck2)
		@event.add_food_truck(@food_truck3)

		 expected = {
         @item1 => {
           quantity: 100,
           food_trucks: [@food_truck1, @food_truck3]
         },
         @item2 => {
           quantity: 7,
           food_trucks: [@food_truck1]
         },
         @item4 => {
           quantity: 50,
           food_trucks: [@food_truck2]
         },
         @item3 => {
           quantity: 35,
           food_trucks: [@food_truck2, @food_truck3]
         },
       }
		#trying to read this terminal output is fucking insane
		assert_equal expected, @event.total_inventory
	end

	def test_it_can_generate_the_hash_structure
		#dont really know how to test this
		assert_equal [], @event.generate_hash
	end

	def test_it_can_list_truck_inventory_keys
		@food_truck3.stock(@item3, 10)

		@event.add_food_truck(@food_truck1)
		@event.add_food_truck(@food_truck2)
		@event.add_food_truck(@food_truck3)

		assert_equal [@item1,@item2,@item4,@item3], @event.inventory_items
	end

	def test_it_has_overstocked
		@food_truck3.stock(@item3, 10)

		@event.add_food_truck(@food_truck1)
		@event.add_food_truck(@food_truck2)
		@event.add_food_truck(@food_truck3)

		@event.overstocked_items
	end
end





