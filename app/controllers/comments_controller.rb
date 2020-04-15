class CommentsController < ApplicationController
  def index
    @comments = Comment.where(claim_id: params[:claim_id])
    respond_with @comments, location: -> { claim_path(params[:claim_id]) }
  end

  def new
    @comment = Comment.new
  end

  def create
    if params[:comment][:parent_id]
      @comment = Comment.find(params[:comment][:parent_id]).replies.build(comment_params)
    else
      @comment = Comment.new(comment_params)
    end
    set_reference
    @comment.save
    respond_with @comment, location: -> { claim_path(params[:claim_id]) }
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_with @comment, location: -> {}
  end

  private

  def set_reference
    @comment.user_id = current_user.id
    @comment.claim_id = params[:claim_id]
  end

  def comment_params
    params.require(:comment).permit(:text, :parent_id, :user_id, :claim_id)
  end
end
