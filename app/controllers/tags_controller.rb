class TagsController < ApplicationController
  def create
    @tag = Tag.find_or_initialize_by(tag_params)
    check_validation
    @tagging = Tagging.new(tag: @tag, taggable: taggable)
    authorize @tag
    ActiveRecord::Base.transaction do
      @tag.save
      @tagging.save
    end
    respond_with @tagging, location: -> { polymorphic_path([taggable]) }
  end

  private

  def taggable
    if params[:claim_id]
      @taggable = Claim.find(params[:claim_id])
    end
  end

  def check_validation
    unless @tag.valid?
      redirect_to polymorphic_path([taggable]), flash: { error: @tag.errors.full_messages.join(',') }
    end
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
