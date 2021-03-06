# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # callback for google
  def google_oauth2
    callback_for(:google)
  end

  # callback for twitter
  def twitter
    callback_for(:twitter)
  end

  # callback for facebook
  def facebook
    callback_for(:facebook)
  end

  # # callback for line
  # def line
  #   callback_for(:line)
  # end

  def callback_for(provider)
    # user.rbのメソッド(from_omniauth)をここで使用
    # 'request.env["omniauth.auth"]'この中に各種アカウントから取得したメールアドレスや、名前のデータが含まれている
    @user = User.from_omniauth(request.env['omniauth.auth'])
    sign_in_and_redirect @user, event: :authentication
    set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
  end

  def failure
    redirect_to root_path
  end
end
