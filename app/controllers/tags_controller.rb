class TagsController < ApplicationController
  def create
    @taggable_tag = Tag.find_or_create_by(tag_params)
    @tag = taggable.tagging.new(tag_id: @taggable_tag[:id])
    authorize @tag
    @tag.save
    respond_with @tag, location: -> { polymorphic_path([taggable]) }
  end

  def destroy
    @tag = taggable.tagging.find_by(tag_id: params[:id])
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
    { resource_errors: @tagable_tag.errors.full_messages.join(',') }
    respond_with @tagable_tag, location: -> { polymorphic_path([taggable]) }
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
