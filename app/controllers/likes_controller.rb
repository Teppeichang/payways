class LikesController < ApplicationController
  before_action :set_search, only: %i[index]
  def index
    @like_posts = current_user.like_posts
  end

  def create
    @like = Like.create(user_id: current_user.id, post_id: params[:id])
    @post = Post.find_by(id: @like.post_id)
    # いいね！の通知の作成
    @post.create_notification_by(current_user)
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, post_id: params[:id])
    @post = Post.find_by(id: @like.post_id)
    @like.destroy
  end

  private

  def set_search
    @q = Post.ransack(params[:q])
  end
end
