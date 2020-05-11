class LoanParticipantsController < ApplicationController
  def create
    @participant = LoanParticipant.new(loan_participant_params)
    authorize @participant
    if @participant.valid?
      @participant.save
      respond_with @participant, location: -> { claim_path(@participant.claim_id) }
    else
      redirect_to claim_path(claim.id), flash: { alert: @participant.errors.full_messages.join(',') }
    end
  end

  def destroy
    @participant = LoanParticipant.find(params[:id])
    authorize @participant
    @participant.destroy
    respond_with @participant, location: -> { claims_path }
  end

  private

  def claim
    @claim ||= Claim.find(params[:loan_participant][:claim_id])
  end

  def flash_interpolation_options
    { resource_errors: claim.errors.full_messages.join(',') }
  end

  def loan_participant_params
    params.require(:loan_participant).permit(:money, :claim_id).merge(user_id: current_user.id)
  end
end
