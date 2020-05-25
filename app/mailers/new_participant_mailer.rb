class NewParticipantMailer < ApplicationMailer
  default from: 'P2P.com'

  def new_notofication(participant_id, claim_id)
    @claim = Claim.find(claim_id)
    @user = @claim.user
    @participant = LoanParticipant.find(participant_id)
    mail(to: @user.email, subject: 'New participant')
  end
end
