class ProfilesController < ApplicationController
  responders :flash
  before_action :set_profile
  before_action :authenticate_user!
  respond_to :html

  def show
    respond_with @profile, location: -> { profile_path(@profile.id) }
  end

  def edit; end

  def update
    @profile.update(profile_params)
    respond_with @profile, flash: true, location: -> { profile_path(@profile.id) }
  end

  private

  def set_profile
    @profile = Profile.find_by(id: params[:id])
  end

  def flash_interpolation_options
    { resource_errors: @profile.errors.full_messages.join(',') }
  end

  def profile_params
    params.require(:profile).permit(:success_credit_project, :success_lend_project,
                                    :phone_number, :address, :avatar)
  end
end
