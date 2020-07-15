class PeriodValidator < ActiveModel::Validator
  def validate(claim)
    payment_frequency = Claim.payment_frequencies[claim.payment_frequency]
    repayment_period = Claim.repayment_periods[claim.repayment_period]
    return if period_value(payment_frequency) <= period_value(repayment_period)

    claim.errors.add(:base, I18n.t('claim.create.alert.periods'))
  end

  private

  def period_value(period)
    period.split(/\.(?=[^.]*$)/).first.to_f
  end
end
