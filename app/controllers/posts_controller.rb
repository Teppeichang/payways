class PostsController < ApplicationController
  before_action :set_post, only:[:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = PostsTag.new
  end

  def create
    @post = PostsTag.new(post_params)
    binding.pry
    if @post.valid?
      @post.save
      redirect_to root_path
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
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end


  def search
    @posts = Post.search(params[:keyword])
  end

  private

  def post_params
    params.require(:posts_tag).permit(:image, :shop_name, :explain, :name).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
