class SuccessClaim
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'success'

  def perform
    Claim.where(status: 'confirmed').each do |claim|
      next if Time.zone.today < claim.updated_at + repayment_period_value(claim)

      claim.success!
    end
  end
end
