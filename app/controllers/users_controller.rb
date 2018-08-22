class UsersController < ApplicationController
	#require 'SubscribeUser'
  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = SubscribeUser.new(user_params).perform
  	#binding.pry	
  	if @user.persisted?
        redirect_to user_path(@user), notice: "Successfully subscribed to service"
  	else
  		render 'new'
  	end
  end


  private

  def user_params
  	#{:first_name => "bhushan", :phone_number => "9894609671"}
  	params.require(:user).permit(:first_name,:phone_number)	
  end
end
