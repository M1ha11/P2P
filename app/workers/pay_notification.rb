class PayNotification
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'notification'

  SECONDS_IN_DAY = 86400.freeze
  EXPIRE_DAY = 4.days.freeze

  def perform
    Claim.where(status: 'confirmed').each do |claim|
      if repayment_day_is_not_today?(claim) && !$redis.exists(claim.id)
        PayMailer.pay_notification(claim).deliver_later!
        $redis.set(claim.id, '', ex: expire_time(claim))
      end
    end
  end

  private

  def repayment_day_is_not_today?(claim)
    repayment_period = claim.repayment_period_value
    repayment_period = 2.week if repayment_period == '0.5.month'
    Time.zone.today < claim.confirmed_at + repayment_period
  end

  def expire_time(claim)
    frequency = claim.payment_frequency_value
    frequency = 2.week if frequency == '0.5.month'
    (frequency - EXPIRE_DAY) / 1.day * SECONDS_IN_DAY
  end
end
