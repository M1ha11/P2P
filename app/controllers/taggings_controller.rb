class TaggingsController < ApplicationController
  def destroy
    @tagging = taggable.taggings.find(params[:id])
    authorize @tagging
    @tagging.destroy
    respond_with @tagging, location: -> { polymorphic_path([taggable]) }
  end

  private

  def taggable
    @taggable ||= begin
      if params[:claim_id]
        Claim.find(params[:claim_id])
      end
    end
  end
end
