class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show, :update, :edit, :destroy]
  before_action :redirect_unless_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show

  end

  def new
    return redirect_to new_profile_path, alert: "プロフィールを登録してください。" if current_user.profile.blank?
    @post = Post.new
  end

  def edit

  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to root_path, notice: "投稿に成功しました。"
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to root_path, notice: "投稿に更新しました。"
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

  def redirect_unless_post
    return redirect_to root_path, alert: "自分の投稿ではありません" if @post.user != current_user
  end
end
