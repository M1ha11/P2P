class ArchiveWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'default'

  ARCHIVE_DAY = 14.days.ago
  AVALIABLE_STATUSES = %w(publicly privatly).map { |status| Claim.statuses[status] }

  def perform
    Claim.where(status: AVALIABLE_STATUSES).where("created_at < ?", ARCHIVE_DAY).find_each do |claim|
      next unless claim.loan_participants.nil?
      
      claim.archive!
    end
  end
end
