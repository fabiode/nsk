# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  #respond_to :js

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    if params.dig(:user, :document).present? && params.dig(:user, :password).nil?
      @user = User.find_by document: params.dig(:user, :document)

      if @user.present?
        flash.clear
        flash[:success] = I18n.t(:document_found_now_password)
      else
        redirect_to new_user_registration_path, alert: I18n.t(:document_not_found)
      end

    elsif params.dig(:user, :document).present? && params.dig(:user, :password).present?
      super do
        redirect_to after_sign_in_path_for(resource) and return
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
