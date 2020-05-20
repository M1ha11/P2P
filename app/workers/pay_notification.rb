class PayNotification
  include Sidekiq::Worker
  sidekiq_options retry: false

  def notice
    Claim.where(status: 'confirmed').where('repayment_period > :date', :date = Time.zone.today).each do |claim|  
      if Time.zone.today == (claim.updated.at + claim.payment_frequency - 3.days)
        PayMailer.pay_notification(claim).deliver_now!
      end
    end
  end
end