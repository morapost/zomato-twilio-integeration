class RandomRestaurant

	include HTTParty

	def self.get_random_restaurant

		zomato_category_ids = [2,3,4,6,7,11,14] #These are the categories taken from zomato API. It includes Night Life,Pub,Cafe etc
		@results = HTTParty.get('https://developers.zomato.com/api/v2.1/search?entity_id=4&entity_type=city&count=10&category=' + "#{zomato_category_ids.sample}",:headers =>{'Content-Type' => 'application/json','user-key' => 'ddd25bb501263163e2f0a9557e59e517'})

		#-- Sometimes above results may return no result and below loop is to prevent that!
		if @results['results_found'].zero?
			@results = HTTParty.get('https://developers.zomato.com/api/v2.1/search?entity_id=4&entity_type=city&count=10&category='+ "#{zomato_category_ids.sample}",:headers =>{'Content-Type' => 'application/json','user-key' => 'ddd25bb501263163e2f0a9557e59e517'})
		end
		
			@results['restaurants'].sample['restaurant']
	end

	def self.create
		@restaurant = Restaurant.new
		random_restaurant = get_random_restaurant
		@restaurant.name = random_restaurant['name']
		@restaurant.city = random_restaurant['location']['city']
		@restaurant.locality = random_restaurant['location']['locality']
		@restaurant.save
		@restaurant
	end
	
end