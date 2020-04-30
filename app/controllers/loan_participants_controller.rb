class LoanParticipantsController < ApplicationController
  before_action :set_claim

  def create
    @participant = current_user.loan_participants.new(loan_participant_params)
    @participant.money = check_wanting_sum
  end

  def destroy
    @participant = loan_participants.find(params[:id])
    @participant.destroy
  end

  private

  def check_wanting_sum
    if @partipant.money > @claim.amount - @claim.loan_participants.select(:money).sum(:money)
      @claim.amount - @claim.loan_participants.select(:money).sum(:money)
    else
      @participant.money
    end
  end

  def set_claim
    @claim = Claim.find(params[:claim_id])
  end

  def loan_participant_params
    params.require(:loan_participants).permit(:money, :user_id, :claim_id)
  end
end
