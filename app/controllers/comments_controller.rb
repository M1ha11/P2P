class CommentsController < ApplicationController
  def new
    @comment = commentable.comments.new
    authorize @comment
  end

  def create
    @comment = commentable.comments.new(comment_params)
    authorize @comment
    @comment.save
    respond_with @comment, location: -> { polymorphic_path([commentable]) }
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    respond_with @comment, location: -> { polymorphic_path([commentable]) }
  end

  private

  def commentable
    if params[:claim_id]
      @commentable = Claim.find(params[:claim_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:text, :parent_id, :commentable_type, :commentable_id)
          .merge(user_id: current_user.id)
  end
end
