class TaggingsController < ApplicationController
  def destroy
    @tagging = taggable.tagging.find_by(tag_id: params[:id])
    authorize @tagging
    @tagging.destroy
    respond_with @tagging, location: -> { polymorphic_path([taggable]) }
  end

  private

  def taggable
    if params[:claim_id]
      @taggable = Claim.find(params[:claim_id])
    end
  end
end
