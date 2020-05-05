module Claims
  class Sort
    DIRECTION = %w(asc desc).freeze
    COLUMNS = %i(created_at amount currency).freeze

    def call(claims, options = {}, direction = {})
      options = check_option(options)
      direction = check_direction(direction)
      claims.order("#{options} #{direction}")
    end

    private

    def check_option(options)
      Claim.column_names.include?(options) && COLUMNS.include?(options.to_sym) ? options.to_sym : COLUMNS[0]
    end

    def check_direction(direction)
      DIRECTION.include?(direction) ? direction.to_sym : DIRECTION[1]
    end
  end
end