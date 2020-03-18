class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]
  prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy]
  prepend_before_action :set_minimum_password_length, only: [:new, :edit]

  # GET /resource/sign_up
  def new
    build_resource
    resource.build_profile
    yield resource if block_given?
    respond_with resource
  end

  def create
    build_resource(sign_up_params)    
    resource.save
    unless params.dig(:user, :profile_attributes, :avatar)
      resource.profile.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'avatar.png')),
                                     filename: 'avatar.png', content_type: 'image/png')
    end
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
end
