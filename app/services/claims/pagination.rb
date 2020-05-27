module Claims
  class Pagination
    def initialize(claims, page)
      @claims = claims
      @page = page
    end

    def paginate
      @claims.paginate(page: @page, per_page: 6)
    end
  end
end
