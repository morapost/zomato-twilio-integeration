SubscribeUser = Struct.new(:user_params) do

  def perform
  	restaurant = create_restaurant
    user = create_user(user_params)
    #user_restaurant = entry_into_join_table
    send_whatsapp_message(restaurant,user)
    
  end

  #Delayed::Job.enqueue UrlBoxService.new.perform.upload_to_s3
  #handle_asynchronously :perform

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
  end

end
