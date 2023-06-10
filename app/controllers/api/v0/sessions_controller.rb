class Api::V0::SessionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_invalid_response
  def create
    @user = User.find_by!(email: params[:session][:email])

    if @user.authenticate(params[:session][:password]) && @user.authenticate(params[:session][:password_confirmation])
      render json: UsersSerializer.new(@user), status: 201
    else
      render_invalid_response
    end
  end

  def render_invalid_response
    render json: { error: "Invalid credentials" }, status: 400
  end
end