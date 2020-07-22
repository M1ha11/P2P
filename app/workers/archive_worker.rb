class ArchiveWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'archive'

  ARCHIVE_DAY = 14.days.ago.freeze
  AVALIABLE_STATUSES = %w[publicly privatly].map { |status| Claim.statuses[status] }.freeze

  def perform
    Claim.where(status: AVALIABLE_STATUSES).where('created_at < ?', ARCHIVE_DAY).find_each do |claim|
      claim.archive!
    end
  end
end
