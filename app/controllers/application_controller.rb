require 'application_responder'

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  around_action :switch_locale

  include Pundit
  protect_from_forgery
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  self.responder = ApplicationResponder
  respond_to :html
  responders :flash

  def default_url_options
    { locale: I18n.locale }
  end

  protected

  def switch_locale(&action)
    # locale = current_user.try(:locale) || I18n.default_locale
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

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

  def user_not_authorized
    flash[:alert] = 'You are not authorized.'
    redirect_to(request.referrer || root_path)
  end
end
