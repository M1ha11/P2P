module Claims
  class Filter
    def initialize(claim, options = {})
      @options = options
      @claim = claim
    end

    def call
      default_claims.merge(with_tag)
    end

    private

    def default_claims
      @claim
    end

    def with_tag
      return default_claims unless @options[:tag].present?

      default_claims.joins(:tags).where(tags: { name: @options[:tag] })
    end
  end
end
