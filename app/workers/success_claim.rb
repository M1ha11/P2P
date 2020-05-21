class SuccessClaim
  include Sidekiq::Worker
  sidekiq_options retry: false

  def success
    Claim.where(status: 'confirmed').each do |claim|
      if Time.zone.today >= claim.updated_at + claim.repayment_period
        ActiveRecord::Base.transaction do
          claim.update(status: 'success')
          claim.user.profile.update(success_credit_project: claim.user.profile.success_credit_project + 1)
          claim.loan_participants.each do |participant|
            participant.user.profile.update(success_lend_project: participant.user.profile.success_lend_project + 1)
          end

          # ActiveRecord::Base.connection.execute("update claims set status = 4 where claim.id = #{claim.id}")
          # ActiveRecord::Base.connection.execute("update profiles
          #                                        set success_credit_project = success_credit_project + 1
          #                                        where profile.id = #{claim.user.profile.id}")
          # claim.loan_participants.each do |participant|
          #   ActiveRecord::Base.connection.execute("update profiles
          #                                          set success_lend_project = success_lend_project + 1 
          #                                          where profiles.id = #{participant.user.profile.id}")
          # end
        end
      end
    end
  end
end