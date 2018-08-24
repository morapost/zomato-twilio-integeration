class Restaurant < ApplicationRecord
	has_many :user_restaurants
	has_many :users, through: :user_restaurants
	after_initialize :init

	include HTTParty

  def find_random_restaurant
  	zomato_category_ids = [2,3,4,6,7,11,14]
    base_url = 'https://developers.zomato.com/api/v2.1/search'
    query    = '?entity_id=4&entity_type=city&count=10&category=' +
                "#{zomato_category_ids.sample}"
    url      = base_url + query
    headers  = { headers: {'Content-Type' => 'application/json',
                            'user-key' => 'ddd25bb501263163e2f0a9557e59e517'} }

    counter = 0
    loop do
      @results = HTTParty.get url, headers
      break if @results["results_found"] != 0 || counter >= 50
      counter += 1
    end

  	 @results["restaurants"].sample["restaurant"]
  end

  def init
  	random_restaurant = find_random_restaurant

    self.name     ||= random_restaurant["name"]
  	self.city     ||= random_restaurant["location"]["city"]
  	self.locality ||= random_restaurant["location"]["locality"]
  end
end
