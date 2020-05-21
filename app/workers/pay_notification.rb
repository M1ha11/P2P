class PayNotification
  include Sidekiq::Worker
  sidekiq_options retry: false

  def notice
    Claim.where(status: 'confirmed').each do |claim|  
      if Time.zone.today < claim.updated_at + claim.repayment_period && Time.zone.today == (claim.updated.at + claim.payment_frequency - 3.days)
        PayMailer.pay_notification(claim).deliver_now!
      end
    end
  end
end