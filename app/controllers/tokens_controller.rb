class TokensController < ApplicationController
  skip_before_action :validate_token
  before_action :set_user, only: :create
  before_action :find_user_via_token, only: :refresh

  def create
    return render json: { message: "Password can't be blank" }, status: 400 unless user_params[:password].present?

    @user.generate_token(user_params[:password])
    render json: @user.map_tokens
  end

  def refresh
    @user.generate_token(refresh: true)

    render json: @user.map_tokens
  end

  private

  def set_user
    @user = User.where(email: user_params[:email]).first

    return render json: { message: 'User not found' }, status: 404 if @user.nil?
  end

  def find_user_via_token
    @user = User.where(refresh_token: user_params[:refresh_token]).first

    return render json: { message: 'Invalid token' }, status: 404 if @user.nil?
  end

  def user_params
    params.require(:token).permit(:email, :password, :refresh_token)
  end
end
