class SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def search
    if params[:q].empty?
      Claim.none
    else
      @search_result = Elasticsearch::Model.search(params[:q] + '*', [Claim]).records.to_a
      render json: @search_result
    end
  end

  def autocomplete
    if params[:q].empty?
      @search_result = []
    else
      @search_result = Elasticsearch::Model.search(params[:q], [Claim]).records.to_a
      render json: @search_result
    end
  end
end
