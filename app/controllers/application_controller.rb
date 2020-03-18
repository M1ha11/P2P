class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    binding.pry
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [
                                        profile_attributes: %i[
                                          phone_number
                                          address
                                          avatar
                                        ]
                                      ]
                                     )

    # devise_parameter_sanitizer.permit(:sign_up) do |user|
    #   user.permit(:email, :password, :password_confirmation, profile_attributes: %i[
    #                                                             phone_number
    #                                                             address
    #                                                             avatar
    #                                                           ]
    #               )
    # end
  end
end
