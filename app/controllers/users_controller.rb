class UsersController < ApplicationController
  skip_before_action :validate_token, in: :create
  before_action :set_user, only: %i[new show update edit destroy]

  def index
    @users = User.map_all

    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    return render json: @user if @user.save

    render json: { message: 'Error creating user', errors: @user.errors }, status: 400
  end

  def update
    return render json: @user if @user.update(user_params)

    render json: { message: 'Error updating user', errors: @user.errors }, status: 400
  end

  def edit; end

  def destroy
    return render json: { message: 'User successfully deleted' } if @user.destroy
  end

  private

  def set_user
    @user = User.where(id: params[:id]).first

    return render json: { message: 'User not found' }, status: 404 if @user.nil?
  end

  def user_params
    params[:user][:password] = params[:password] if params[:password].present?
    params.require(:user).permit(:id, :name, :email, :password)
  end
end
