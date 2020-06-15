class ProfilesController < ApplicationController
  def show
    respond_with profile, location: -> { profile_path(profile.id) }
  end

  def edit
    profile
  end

  def update
    profile.update(profile_params)
    respond_with profile, flash: true, location: -> { profile_path(profile.id) }
  end

  private

  def profile
    @profile ||= Profile.find(params[:id])
    authorize @profile
  end

  def flash_interpolation_options
    { resource_errors: profile.errors.full_messages.join(',') }
  end

  def profile_params
    params.require(:profile).permit(:success_credit_project, :success_lend_project,
                                    :phone_number, :address, :avatar, :locale)
  end
end
