class Restaurant < ApplicationRecord
	has_many :user_restaurants
	has_many :users, through: :user_restaurants
	after_initialize :init
	
	include HTTParty

	def find_random_restaurant

		zomato_category_ids = [2,3,4,6,7,11,14]
		@results = HTTParty.get('https://developers.zomato.com/api/v2.1/search?entity_id=4&entity_type=city&count=10&category='+ "#{zomato_category_ids.sample}",:headers =>{'Content-Type' => 'application/json','user-key' => 'ddd25bb501263163e2f0a9557e59e517'})
		#binding.pry
		unless @results["results_found"] != 0
			@results = HTTParty.get('https://developers.zomato.com/api/v2.1/search?entity_id=4&entity_type=city&count=10&category='+ "#{zomato_category_ids.sample}",:headers =>{'Content-Type' => 'application/json','user-key' => 'ddd25bb501263163e2f0a9557e59e517'})
		end
		
			@results["restaurants"].sample["restaurant"]
	end

	def init
		random_restaurant = find_random_restaurant
		#binding.pry
		self.name ||= random_restaurant["name"]
		self.city ||= random_restaurant["location"]["city"]
		self.locality ||= random_restaurant["location"]["locality"]	
	end
	
end
