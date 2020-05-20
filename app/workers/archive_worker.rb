class ArchiveWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'default'

  def perform
    Claim.where("(status = 0 OR status = 1) AND created_at < ?", 14.days.ago).each do |claim|
      # claim.update(status: 'archive') && claim.save  #if claim.loan_participants.nil?
      ActiveRecord::Base.connection.execute("update claims set status = 3 where claims.id = #{claim.id}")
    end
  end
end
