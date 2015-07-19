class PostsController < ApplicationController
 
 # index page shows up to 40 most recent posts starting with most recent
  def index
    @posts = Post.order(id: :desc).limit(40)
    @title = "The Staff Room - Latest Posts"
  end

  # find individual post by id
  # set links to previous and next post
  def show
    @post = Post.find(params[:id])   
    @previous = Post.where("id < ?", params[:id]).order(:created_at).last   
    @next = Post.where("id > ?", params[:id]).order(:created_at).first 
    @title = @post.title
  end

  def new
    @post = Post.new
    @title = "Create new post"
  end

  # use if statement so that only user can post
  def create
    if current_user
    @post = current_user.posts.create(post_params)
    @post.save
    redirect_to user_path(current_user)
    else
      redirect_to users_path
    end
  end

  def destroy
    
  end

 # strong params for post, including post avatar
  private
  def post_params
    params.require(:post).permit(:id, :title, :text, :user_id, :avatar, :avatar_file_name)
  end

end
