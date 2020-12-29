class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
    @posts = Post.tagged_with(params[:tag].split(/[[:blank:]]+/).select(&:present?)) if params[:tag]
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
    split_keywords = params[:keyword].split(/[[:blank]]+/) # 検索キーワードを分割可能にする
    @posts = []
    split_keywords.each do |keyword| # 分割したキーワードごとに検索する
      if keyword == ''
        @posts += Post.where('shop_name LIKE(?)', "%#{keyword}%") # 部分一致でキーワードごとに検索
      else
        @posts.uniq! # 検索レコードの重複を防ぐための処理
      end
    end
    @posts = Post.search(params[:keyword]).page(params[:page]).per(10)
  end

  private

  def post_params
    params.require(:post).permit(:image, :shop_name, :explain, :tag_list).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
