  require 'application_responder'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_locale

  include Pundit
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  self.responder = ApplicationResponder
  respond_to :html
  responders :flash

  protected

  def set_locale
    # locale = current_user.try(:profile).try(:locale) || I18n.default_locale
    # I18n.with_locale(locale, &action)
    I18n.locale = current_user.try(:profile).try(:locale) if current_user.present?
    I18n.locale = I18n.default_locale
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [
                                        profile_attributes: %i[
                                          phone_number
                                          address
                                          avatar
                                          locale
                                        ]
                                      ])
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized.'
    redirect_to(request.referrer || root_path)
  end
end
