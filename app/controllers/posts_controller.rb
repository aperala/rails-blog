class PostsController < ApplicationController
  def index
    @posts = Post.order(id: :desc).limit(40)
  end

  def show
    @post = Post.find(params[:id])   
    @previous = Post.where("id < ?", params[:id]).order(:created_at).last   
    @next = Post.where("id > ?", params[:id]).order(:created_at).first 
  end

  def new
    @post = Post.new
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

  def destroy
    
  end


  private
  def post_params
    params.require(:post).permit(:id, :title, :text, :user_id, :avatar, :avatar_file_name)
  end

end
