# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  #before_action :sanitize_document
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(sanitized_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with(resource, location: new_user_session_path)
    else
      flash[:alert] = I18n.t(:document_or_email_not_valid)
      respond_with(resource)
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
  #
  def sanitized_params
    document = resource_params[:document]

    if document.present?
      document = document.gsub(/\D/,'')
      old_params = resource_params
      resource_params = ActionController::Parameters.new(document: document, email: old_params[:email])
      #resource.document = document if resource
    end
  end
end
