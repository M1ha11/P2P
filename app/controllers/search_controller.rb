class SearchController < ApplicationController
  def search
    if params[:q].empty?
    else
      search_result = Elasticsearch::Model.search(params[:q], [Claim]).records.to_a
    end
  end
end
