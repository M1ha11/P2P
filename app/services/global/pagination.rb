module Global
  class Pagination
    def initialize(model, page, per_page)
      @model = model
      @page = page
      @per_page = per_page
    end

    def paginate
      @model.paginate(page: @page, per_page: @per_page)
    end
  end
end