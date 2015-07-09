class PostsController < ApplicationController
  def index
    @posts = Post.order(id: :desc).limit(20)
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
  end

  def new
    @post = Post.new

  end

  def create
    if current_user
    @post = current_user.posts.create(post_params)
    @post.save
    redirect_to user_path
    else
      redirect_to user_path
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :text, :user_id)
  end

end
