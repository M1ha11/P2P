class SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def search
    if params[:q].empty?
      Claim.none
    else
      @search_result = Elasticsearch::Model.search(params[:q] + '*', [Claim, Tag]).records.to_a
      @search_result = policy_scope(@search_result, policy_scope_class: SearchPolicy::Scope)
      render json: @search_result
    end
  end
end
