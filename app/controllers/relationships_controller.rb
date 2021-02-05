class RelationshipsController < ApplicationController
  before_action :set_search
  
  def create
    @user = User.find(params[:following_id])
    current_user.follow(@user)
    @user.create_notification_follow!(current_user)
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
  end

  private

  def set_search
    @q = Post.ransack(params[:q])
  end

end
