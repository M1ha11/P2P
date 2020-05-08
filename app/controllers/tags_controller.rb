class TagsController < ApplicationController
  def create
    @tag = taggable.tags.build(tag_params)
    authorize @tag
    @tag.save
    respond_with @tag, location: -> { polymorphic_path([taggable]) }
  end

  def destroy
    @tag = taggable.tags.find(params[:id])
    authorize @tag
    @tag.destroy
    respond_with @tag, location: -> { polymorphic_path([taggable]) }
  end

  private

  def taggable
    if params[:claim_id]
      @taggable = Claim.find(params[:claim_id])
    end
  end

  def flash_interpolation_options
    { resource_errors: @tag.errors.full_messages.join(',') }
  end

  def tag_params
    params.require(:tag).permit(:name, :taggable_type, :taggable_id)
  end
end
