class PayMailer < ApplicationMailer
  default from: 'P2P.com'

  def pay_notification(claim_id)
    @claim = Claim.find(claim_id)
    @user = @claim.user
    mail(to: @user.email, subject: 'Pay time')
  end
end
