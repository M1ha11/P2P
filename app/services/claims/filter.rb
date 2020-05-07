module Claims
  class Filter
    def initialize(claim, name = {})
      @name = name
      @claim = claim
    end

    def call
      default_claims.merge(with_tag)
    end

    private

    def default_claims
      @claim.includes(:tags)
    end

    def with_tag
      return default_claims unless @name.present?

      default_claims.joins(:tags).where(tags: { name: @name })
    end
  end
end
