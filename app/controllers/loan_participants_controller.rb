class LoanParticipantsController < ApplicationController
  def create
    @participant = LoanParticipant.new(loan_participant_params)
    check_wanting_sum
    @participant.save
    respond_with @participant, location: -> { claim_path(@participant.claim_id) }
  end

  def destroy
    @participant = LoanParticipant.find(params[:id])
    @participant.destroy
    respond_with @participant, location: -> { claims_path }
  end

  private

  def check_wanting_sum
    if @partipant.money > claim.amount - claim.loan_participants.sum(:money)
      @participant.money = claim.amount - claim.loan_participants.sum(:money)
    else
      @participant.money
    end
  end

  def claim
    @claim ||= Claim.find(params[:claim_id])
  end

  def loan_participant_params
    params.require(:loan_participant).permit(:money, :claim_id).merge(user_id: current_user.id)
  end
end
