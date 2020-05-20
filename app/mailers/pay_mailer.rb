class PayMailer < ApplicationMailer
  default from: "P2P@example.com"

  def pay_notification(claim)
    @user = claim.user
    @claim = claim
    mail(to: @user.email, subject: 'Should pay')
  end
end
