class ArchiveWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    claims = Claim.where("(status = 0 OR status = 1) AND created_at < ?", 14.days.ago)
    claims.each do |claim|
      claim.update(status: 'archive') if claim.loan_participants.nil?
    end
  end
end
