module Claims
  class Sort
    AVAILIABLE_DIRECTION = %w[asc desc].freeze

    def call(claims, sort_field = 'created_at', direction = 'asc')
      sort_field = check_sort_field(sort_field)
      direction = check_direction(direction)
      claims.order("#{sort_field} #{direction}")
    end

    private

    def check_sort_field(sort_field)
      Claim.column_names.include?(sort_field) ? sort_field : 'created_at'
    end

    def check_direction(direction)
      AVAILIABLE_DIRECTION.include?(direction) ? direction : 'asc'
    end
  end
end
