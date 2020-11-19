class PostsController < ApplicationController
  before_action :find_post, only: [:show, :update, :edit, :destroy]

  def index
    @posts = Post.all
  end

  def show

  end

  def new
    @post = Post.new
  end

  def edit

  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path,  notice: "投稿に成功しました。"
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to root_path,  notice: "投稿に更新しました。"
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to root_path,  notice: "投稿に削除しました。"
    else
      redirect_to root_path,  alert: "投稿に削除できませんでした。"
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, images: [])
    
  end
end
