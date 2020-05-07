module Tags
  class TagCloud
    def initialize(type)
      @type = type
    end

    def show
      Tag.distinct.select(:name).where(taggable_type: @type)
    end
  end
end