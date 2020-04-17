class CommentsController < ApplicationController
  def index
    @comments = Comment.where(commentable_id: params[:claim_id])
    respond_with @comments, location: -> { claim_path(params[:claim_id]) }
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = commentable.comments.new(comment_params)
    @comment.save
    respond_with @comment, location: -> { claim_path(params[:claim_id]) }
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_with @comment, location: -> { claim_path(params[:claim_id]) }
  end

  private

  def commentable
    if params[:claim_id]
      Claim.find(params[:claim_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:text, :parent_id).merge(user_id: current_user.id)
  end
end
