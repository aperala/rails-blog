class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comment.create(comment_params)
    @comment.save
    redirect to post_path(@comment.post)
  end


  private
    def comment_params
      params.require(:comment).permit(:body, :post_id, :user_id)
    end

end
