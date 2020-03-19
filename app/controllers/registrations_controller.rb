class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: %i[new create cancel]
  prepend_before_action :authenticate_scope!, only: %i[edit update destroy]
  prepend_before_action :set_minimum_password_length, only: %i[new edit]

  # GET /resource/sign_up
  def new
    build_resource
    resource.build_profile
    yield resource if block_given?
    respond_with resource
  end
end
