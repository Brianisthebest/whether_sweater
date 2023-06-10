class Api::V0::SessionsController < ApplicationController
  def create
    @user = User.find_by!(email: params[:session][:email])

    if @user.authenticate(params[:session][:password])
      render json: UsersSerializer.new(@user), status: 201
    end
  end
end