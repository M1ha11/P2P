class CommentsController < ApplicationController
  def index
    @comments = Comment.where(claims_id: params[:claim_id])
    respond_with @claims, location: -> { claim_path(params[:claim_id]) }
  end

  def new
    @comment = Comment.new
  end

  def create
    if params[:parent_id]
      @comment = Comment.find(params[:parent_id]).build(comment_params)
    else
      @comment = Comment.new(comment_params)
    end
    @comment.save
    respond_with @comment, location: -> { claim_path(params[:claim_id]) }
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_with @comment, location: -> {}
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :parent_id, user: [:id], claim: [:id])
  end
end
