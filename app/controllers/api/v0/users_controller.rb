class Api::V0::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    @user.api_key = SecureRandom.hex

    if @user.save
      render json: UsersSerializer.new(@user), status: 201
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end