class NewParticipantMailer < ApplicationMailer
  default from: "P2P@example.com"

  def new_notofication(claim)
    @user = claim.user
    @claim = claim
    mail(to: @user.email, subject: 'Should pay')
  end
end
