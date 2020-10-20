class LikesController < ApplicationController
  
  def index
    @like_posts = current_user.like_posts
  end

  def create
    @like = Like.create(user_id: current_user.id, post_id: params[:id])
    @post = Post.find_by(id: @like.post_id)
  end 

  def destroy
    @like = Like.find_by(user_id: current_user.id, post_id: params[:id])
    @post = Post.find_by(id: @like.post_id)
    @like.destroy
  end

end
