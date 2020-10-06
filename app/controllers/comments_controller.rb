class CommentsController < ApplicationController
  
  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to post_path(comment.post.id)
    else
      flash[:alert] = "コメントを入力してください"
      redirect_to post_path(comment.post.id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end

end
