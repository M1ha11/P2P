class SuccessClaim
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'success'

  def perform
    Claim.where(status: 'confirmed').each do |claim|
      repayment_period = claim.repayment_period_value
      repayment_period = 2.week if repayment_period == '0.5.month'
      next if Time.zone.today < claim.confirmed_at + repayment_period

      claim.success!
    end
  end
end
