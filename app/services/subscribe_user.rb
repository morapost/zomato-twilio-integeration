SubscribeUser = Struct.new(:user_params) do

  def perform
  	restaurant = create_restaurant
    user = create_user(user_params)
    update_join_table(user,restaurant)
    send_whatsapp_message(restaurant,user)
    
  end


  private

  def create_restaurant
    @restaurant = RandomRestaurant.create #This will call RandomRestaurant class defined in Services folder"
  end

  def create_user(user_params)
  	  @user = User.create(user_params)
  end

  def send_whatsapp_message(restaurant,user)
  	message = "Meet up at #{restaurant.name} for #{user.first_name} is confirmed"
  	TwilioWhatsappMessenger.new(message).call
    @user
  end

  def update_join_table(user,restaurant)
    UserRestaurant.create(user_id: user.id, restaurant_id: restaurant.id)
  end

end
