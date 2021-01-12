class Event
	attr_reader :name,
				:food_trucks
	def initialize(name)
		@name = name
		@food_trucks = []
	end

	def add_food_truck(truck)
		@food_trucks << truck
	end

	def food_truck_names
		@food_trucks.map do |truck|
			truck.name
		end
	end

	def food_trucks_that_sell(item)
		@food_trucks.find_all do |truck|
			truck.check_stock(item) > 0
		end
	end

	def get_item_names
		@food_trucks.flat_map do |truck|
			truck.inventory.map do |item,quantity|
				item.name
			end
		end.uniq
	end

	def sorted_item_list
		items = get_item_names
		items.sort { |a, b| a <=> b } #this is preforming an in place swap using -1, 0 or 1 
																	# depending on the relation of the two block variables
	end

	def inventory_items
		@food_trucks.flat_map do |truck|
			truck.inventory.keys
		end.uniq
	end

	def generate_hash
		inventory_items.collect do |item| 
			[item , {
				quantity: 0,
				food_trucks: [ ]
				}]
			end	
	end

	def total_inventory
		breakdown = Hash[generate_hash]
			
		@food_trucks.each do |truck|
       truck.inventory.each do |item, quantity|
         breakdown[item][:quantity] += quantity
         breakdown[item][:food_trucks] << truck
       end
     end
     	breakdown
	end

	def condition_one
		breakdown = total_inventory

		breakdown.find_all do |item,item_details|
			item_details[:quantity] > 50 &&
		end
	end

	def condition_two
		breakdown = total_inventory
		!breakdown.one? do |item,item_details|
			#code for appearing in multiple places, couldn't get to it in time rip
		end

	end

	def overstocked_items
		(condition_one +  condition_two).uniq
	
	end

end