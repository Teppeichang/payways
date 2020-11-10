class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comments = @post.comments.includes(:user)
    if @comment.save
      @post.create_notification_comment(current_user, @comment.id)
      render :create
    else
      @post = Post.find(params[:post_id])
      @comments = @post.comments.includes(:user)
      render :show
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
