SubscribeUser = Struct.new(:user_params) do

  def perform
  	restaurant = create_restaurant
    user = create_user(user_params)
    update_join_table(user,restaurant)
    send_whatsapp_message(restaurant,user)
    
  end


  private

  def create_restaurant
    @restaurant = RandomRestaurant.create
    #puts "Restaurant Created successfully #{@restaurant.name}"
  end

  def create_user(user_params)
  	  @user = User.create(user_params)
      #puts "successfully created user #{@user.first_name}"
  end

  def send_whatsapp_message(restaurant,user)
  	message = "Meet up at #{restaurant.name} for #{user.first_name} is confirmed"
  	TwilioWhatsappMessenger.new(message).call
    return @user
  end

  def update_join_table(user,restaurant)
    UserRestaurant.create(user.id,restaurant.id)
  end

end
