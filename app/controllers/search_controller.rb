class SearchController < ApplicationController
  def search
    if params[:q].empty?
      @search_result = []
    else
      @search_result = Elasticsearch::Model.search(params[:q], [Claim]).records.to_a
      respond_with @search_result, location: -> { search_path }
    end
  end
end
