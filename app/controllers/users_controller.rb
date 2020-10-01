class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
  end

  def update
  end
  
end
