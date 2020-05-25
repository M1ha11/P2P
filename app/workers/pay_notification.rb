class PayNotification
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    Claim.where(status: 'confirmed').each do |claim|  
      if Time.zone.today < confirm_date(claim) + repayment_period_value(claim)
        notificate(claim)
      end
    end
  end

  def notificate(claim)
    period = 1
    while Time.zone.today <= notification_date(claim, period) do
      if Time.zone.today == notification_date(claim, period)
        return PayMailer.pay_notification(claim).deliver_later!
      end
      period = period + 1
    end
  end

  private

  def notification_date(claim, period)
    confirm_date(claim) + current_frequency(claim, period) - 3.days
  end

  def current_frequency(claim, period)
    frequency = payment_frequency_value(claim)
    number_of_month = (frequency.split(/\.(?=[^.]*$)/).first.to_f * period).to_s
    month = frequency.split(/\.(?=[^.]*$)/).last
    number_of_month.concat('.').concat(month)
  end
end