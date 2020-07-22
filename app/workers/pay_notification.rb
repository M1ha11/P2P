class PayNotification
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'notification'

  EXPIRE_DAY = 4.days.freeze

  def perform
    Claim.confirmed.each do |claim|
      if repayment_day_is_not_today?(claim) && !$redis.exists(claim.id)
        PayMailer.pay_notification(claim.id).deliver_later!
        $redis.set(claim.id, '', ex: expire_time(claim))
      end
    end
  end

  private

  def repayment_day_is_not_today?(claim)
    repayment_period = claim.repayment_period_value
    Time.zone.today < claim.confirmed_at + repayment_period
  end

  def expire_time(claim)
    frequency = claim.payment_frequency_value
    (frequency - EXPIRE_DAY).to_i
  end
end
