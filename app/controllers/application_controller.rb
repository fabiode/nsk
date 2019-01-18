class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: "klasme", password: "secrets" if Rails.env.staging?
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    coupons_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :document, :email, :name, :surname, :phone, :mobile_phone
    ])
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:document, :email, :password)
    end
  end

end
