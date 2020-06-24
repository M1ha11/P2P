class NewParticipantMailer < ApplicationMailer
  default from: 'P2P.com'

  def notification(participant_id)
    @participant = LoanParticipant.find(participant_id)
    @claim = @participant.claim
    @user = @claim.user
    mail(to: @user.email, subject: 'New participant')
  end
end
