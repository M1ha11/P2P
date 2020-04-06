class ClaimFilter
  def initialize(options = {})
    @options = options
  end

  def call
  end

  private

  def all_public_claims
    default_claim.where(status: 'publicly')
  end

  def user_claims
    return unless @options.key?(:user_id)
    default_claim.where(user_id: @options[user_id])
  end

  def default_claim

  end
end