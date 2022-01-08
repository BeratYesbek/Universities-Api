class ApplicationController < ActionController::Base
  include Pundit
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname, :email, :password, :password_confirmation])
  end

  def user_not_authorized
    @message = "You are not authorized to perform this action."
    render json: { message: @message, success: false }, status: 401
  end

end
