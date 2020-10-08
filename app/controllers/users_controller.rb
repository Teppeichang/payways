class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      flash.now[:alert] = "ユーザー名とメールアドレスを入力してください"
      render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :image)
  end

end
