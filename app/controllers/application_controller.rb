class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password password_confirmation favorite_shop prefecture_id])
  end

  def set_search
    @q = Post.ransack(params[:q])
  end
end
