class NotificationsController < ApplicationController
  before_action :set_search
  
  def index
    @notifications = current_user.passive_notifications
  end

  def destroy
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end

  private

  def set_search
    @q = Post.ransack(params[:q])
  end

end
