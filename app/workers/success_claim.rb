class SuccessClaim
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'success'

  def perform
    Claim.confirmed.each do |claim|
      repayment_period = claim.repayment_period_value
      next if Time.zone.today < claim.confirmed_at + repayment_period

      claim.success!
    end
  end
end
