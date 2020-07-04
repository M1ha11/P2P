class CustomSessionsController < Devise::SessionsController
  after_action :after_login, :only => :create

  def after_login
    switch_locale
  end

  private

  def switch_locale
    I18n.locale = current_user.profile.locale || I18n.default_locale
  end
end