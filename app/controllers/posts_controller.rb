class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.order(id: :desc).limit(40)
    @title = "The Staff Room - Latest Posts"
  end

  def show
    @previous = Post.where("id < ?", params[:id]).order(:created_at).last   
    @next = Post.where("id > ?", params[:id]).order(:created_at).first 
    @title = @post.title
  end

  def new
    @post = Post.new
    @title = "Create new post"
  end

  def create
    if current_user
      @post = current_user.posts.create(post_params)
      @post.save
      redirect_to user_path(current_user)
    else
      redirect_to users_path
    end
  end

  def edit
  end

  def update

  end

  def destroy
    
  end

 # strong params for post, including post avatar
  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:id, :title, :text, :user_id, :avatar, :avatar_file_name)
  end

end
