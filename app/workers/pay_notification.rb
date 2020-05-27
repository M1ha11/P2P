class PayNotification
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'notification'

  REDIS = Redis.new(host: "localhost", port: 6380, db: 15).freeze
  SECONDS_IN_DAY = 86400.freeze
  EXPIRE_DAY = 4.days.freeze

  def perform
    Claim.where(status: 'confirmed').each do |claim|
      if repayment_day_is_not_today?(claim) && !REDIS.exists(claim.id)
        PayMailer.pay_notification(claim).deliver_later!
        REDIS.set(claim.id, '', ex: expire_time(claim))
      end
    end
  end

  private

  def repayment_day_is_not_today?(claim)
    Time.zone.today < claim.updated_at + repayment_period_value(claim)
  end

  def expire_time(claim)
    frequency = payment_frequency_value(claim)
    (frequency - EXPIRE_DAY) / 1.day * SECONDS_IN_DAY
  end
end
