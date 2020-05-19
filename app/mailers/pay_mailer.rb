class PayMailer < ApplicationMailer
  default from: "P2P@example.com"

  def pay_notification
    @user = params[:user]
    @claim = params[:claim]
    mail(to: @user.email, subject: 'Should pay')
  end
end
