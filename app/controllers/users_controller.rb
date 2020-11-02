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

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "退会が完了しました。またのご利用をお待ちしております。"
    redirect_to root_path
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :favorite_shop, :prefecture_id, :introduce)
  end

end
