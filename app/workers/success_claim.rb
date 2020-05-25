class SuccessClaim
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    Claim.where(status: 'confirmed').each do |claim|
      next if Time.zone.today < confirm_date(claim) + repayment_period_value(claim)

      claim.success!
    end
  end
end