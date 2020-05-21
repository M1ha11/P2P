class NewParticipantMailer < ApplicationMailer
  default from: "P2P@example.com"

  def new_notofication(participant, claim)
    @user = claim.user
    @claim = claim
    @participant = participant
    mail(to: @user.email, subject: 'New participant')
  end
end
