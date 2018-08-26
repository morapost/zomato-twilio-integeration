class UsersController < ApplicationController

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = SubscribeUser.new(user_params).perform

  	if @user.persisted?
      redirect_to user_path(@user), notice: "Successfully subscribed to service"
  	else
  		render 'new'
  	end
  end


  private

  def user_params
  	params.require(:user).permit(:first_name,:phone_number)	
  end
end
