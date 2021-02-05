class HomesController < ApplicationController
  before_action :set_search

  def index; end

  private

  def set_search
    @q = Post.ransack(params[:q])
  end
end
