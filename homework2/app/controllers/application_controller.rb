class ApplicationController < ActionController::Base
  before_action :configure_permitted_parametersod_name, if: :devise_controller?

  protected

  def configure_permitted_parametersod_name
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:signin, :num, :password) }
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:num,:username, :password, :password_confirmation,:status)
    end
  end
end
