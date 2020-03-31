require 'application_responder'

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  self.responder = ApplicationResponder
  respond_to :html
  responders :flash

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [
                                        profile_attributes: %i[
                                          phone_number
                                          address
                                          avatar
                                        ]
                                      ])
  end
end
