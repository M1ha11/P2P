module Claims
  class Filter
    def initialize(claim, options = {})
      @options = options
      @claim = claim
    end

    def call
      default_claim.merge(with_tag)
    end

    private

    def default_claim
      @claim
    end

    def with_tag
      return @claim unless @options[:tag].present?

      @claim.includes(:tags).where(tags: { name: @options[:tag] })
    end
  end
end
