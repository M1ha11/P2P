class ProfilesController < ApplicationController
  before_action :set_profile
  before_action :authenticate_user!

  def show
    respond_to do |format|
      if @profile && current_user.profile.id == @profile.id
        format.html { render :show }
      else
        format.html { redirect_to root_url }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      binding.pry
      if @profile.update(profile_params)
        binding.pry
        format.html { redirect_to @profile, notice: 'Profile was successfully updated!' }
      else
        flash[:errors] = @profile.errors.full_message
        format.html { render :edit }
      end
    end
  end

  private

  def set_profile
    @profile = Profile.find_by(id: params[:id])
  end

  def profile_params
    params.require(:profile).permit(:success_credit_project, :success_lend_project,
                                    :phone_number, :address, :avatar,
                                    user_attributes: [:email, :password, :password_confirmation])
  end
end
