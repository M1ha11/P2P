class CommentsController < ApplicationController
  def new
    binding.pry
    @comment = commentable.comments.new
    authorize @comment
  end

  def create
    @comment = commentable.comments.new(comment_params)
    authorize @comment
    if !@comment.valid?
      flash[:alert] = @comment.errors.full_messages.join(', ')
      respond_with flash[:alert], location: -> { polymorphic_path([commentable]) }
    else
      @comment.save
      respond_with @comment, location: -> { polymorphic_path([commentable]) }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    respond_with @comment, location: -> { polymorphic_path([commentable]) }
  end

  private

  def commentable
    @commentable ||= begin
      if params[:claim_id]
        Claim.find(params[:claim_id])
      end
    end
  end

  def comment_params
    params.require(:comment).permit(:text, :parent_id, :commentable_type, :commentable_id)
          .merge(user_id: current_user.id)
  end
end
