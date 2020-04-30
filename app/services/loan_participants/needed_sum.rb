module LoanParticipants
  class NeededSum
    def check_wanting_sum(claim, partipant)
      if partipant.money > claim.amount - claim.loan_participants.select(:money).sum(:money)
        participant.money = claim.amount - claim.loan_participants.select(:money).sum(:money)
      else
        participant.money
      end
    end
  end
end