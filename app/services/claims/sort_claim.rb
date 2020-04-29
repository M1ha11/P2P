module Claims
  class SortClaim
    def initialize(claims, options = {})
      @claims = claims
      @options = options
    end

    def sort
      if @options.nil?
        @claims
      else
        @claims.merge(by_amount)
               .merge(by_currency)
               .merge(by_repayment_period)
               .merge(by_payment_frequency)
      end
    end

    private

    def by_amount
      return @claims unless @options['amount'].present?
      @claims.order(amount: :asc)
    end

    def by_currency
      return @claims unless @options['currency'].present?
      @claims.order(currency: :asc)
    end

    def by_repayment_period
      return @claims unless @options['repayment_period'].present?
      @claims.order(repayment_period: :asc)
    end

    def by_payment_frequency
      return @claims unless @options['payment_frequency'].present?
      @claims.order(payment_frequency: :asc)
    end
  end
end