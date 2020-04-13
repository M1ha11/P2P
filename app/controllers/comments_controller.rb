class CommentsController < ApplicationController
  def index
    @comments = Comment.all
    respond_with @claims, location: -> { claim_path(claim_id) }
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(comment_params)
    respond_with @comment, location: -> { claim_path(claim_id) }
  end

  def destroy
  end

  private

  def comment
  end

  def comment_params
    params.require(:comment).permit(:text, :parent_id, :user_id, :claim_id)
  end
end
