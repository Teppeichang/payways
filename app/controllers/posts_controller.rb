class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_search, only: %i[index new show edit]

  def index
    @posts = Post.all.order(created_at: :desc)
    @posts = Post.tagged_with(params[:tag].split(/[[:blank:]]+/)) if params[:tag]
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def search
    @q = Post.search(search_params)
    @posts = @q.result.includes(params[:keyword]).page(params[:page]).per(10)
  end

  private

  def post_params
    params.require(:post).permit(:image, :shop_name, :explain, :tag_list).merge(user_id: current_user.id)
  end

  def search_params
    params.require(:q).permit(:shop_name_cont)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_search
    @q = Post.ransack(params[:q])
  end
end
