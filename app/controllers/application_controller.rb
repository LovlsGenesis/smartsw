class ApplicationController < ActionController::API
  before_action :validate_token

  def validate_token
    token = request.headers['Authorization'].split(' ').last
    @user = User.where(token:).first
    return render json: { message: 'Invalid token' }, status: 400 unless @user.present?

    render json: { message: 'Expired token, please refresh it' }, status: 400 if Time.now > @user.token_expiration_date
  end

  private

  def set_user
    @user = User.where(id: params[:id]).first

    return render json: { message: 'User not found' }, status: 404 if @user.nil?
  end
end
