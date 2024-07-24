# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :create_cart, only: [:create]

  private

  # Configure the permitted parameters for sign up and account update
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :password_confirmation, :current_password])
  end

  # Create a cart for the user after they sign up
  def create_cart
    if user_signed_in?
      Cart.create(user: current_user)
    end
  end
end
