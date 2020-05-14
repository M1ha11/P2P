class TagsController < ApplicationController
  def create
    @tag = Tag.find_or_initialize_by(tag_params)
    if !@tag.valid?
      redirect_to polymorphic_path([taggable]), flash: { alert: @tag.errors.full_messages.join(',') }
    else
      create_tagging_with_tag
      respond_with @tagging, location: -> { polymorphic_path([taggable]) }
    end
  end

  private

  def taggable
    @taggable ||= begin
      if params[:claim_id]
        Claim.find(params[:claim_id])
      end
    end
  end

  def create_tagging_with_tag
    @tagging = Tagging.new(tag: @tag, taggable: taggable)
    authorize @tag
    ActiveRecord::Base.transaction do
      @tag.save
      @tagging.save
    end
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
