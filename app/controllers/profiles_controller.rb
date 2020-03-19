class ProfilesController < ApplicationController
  before_action :set_profile
  before_action :authenticate_user!
  before_action :skip_confirmation, only: [:update]
  respond_to :html

  def show
    if @profile && current_user.profile.id == @profile.id
      respond_with @profile, location: -> { profile_path(@profile.id) }
    else
      redirect_to root_url
    end
  end

  def edit; end

  def update
    binding.pry
    if @profile.update(profile_params)
      respond_with @profile, location: -> { profile_path(@profile.id) }
    else
      flash[:errors] = @profile.errors.full_messages
      respond_with @profile.errors.messages, location: -> { edit_profile_path(@profile.id) }
    end
  end

  private

  def set_profile
    @profile = Profile.find_by(id: params[:id])
  end

  def skip_confirmation
    binding.pry
    @profile.user.skip_confirmation_notification!
  end

  def profile_params
    params.require(:profile).permit(:success_credit_project, :success_lend_project,
                                    :phone_number, :address, :avatar,
                                    user_attributes: %i[id email])
  end
end
