class RandomRestaurant
	def self.create
		@restaurant = Restaurant.new
		@restaurant.save
		@restaurant
	end
	
end