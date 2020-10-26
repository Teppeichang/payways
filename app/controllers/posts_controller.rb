class PostsController < ApplicationController

  before_action :set_post, only:[:show, :edit, :update, :destroy]  
  
  def index
    @posts = Post.all.order(created_at: :desc)
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    end
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

  def edit
  end

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
    @posts = Post.search(params[:keyword])
    @posts = Post.all.page(params[:page]).per(10)
  end

  private

  def post_params
    params.require(:post).permit(:image, :shop_name, :explain, :tag_list).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
