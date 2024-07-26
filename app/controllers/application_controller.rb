class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :username, :email, :password, :password_confirmation,
      :first_name, :last_name, 
      :address_street, :address_city, :address_state, :address_zip_code
    ])
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :username, :email, :password, :password_confirmation, 
      :current_password, :first_name, :last_name, 
      :address_street, :address_city, :address_state, :address_zip_code
    ])
  end
end
