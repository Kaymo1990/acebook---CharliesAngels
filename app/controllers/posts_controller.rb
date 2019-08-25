class PostsController < ApplicationController


  # before_action :authenticate_user!, only: [:like]

  respond_to :js, :html, :json
  protect_from_forgery

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
      if @post.save
        if @post.wall_id == 'posts'
          redirect_to posts_path
        else
          redirect_to user_path(@post.wall_id)
        end
      else
        render 'new'
      end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    if @post.wall_id == 'posts'
      respond_with(@post, :location => posts_path)
    else
      respond_with(@post, :location => user_path(@post.wall_id))
    end
  end

  def index
    if logged_in?
      @posts = Post.all
    else
      redirect_to sessions_new_url
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    if @post.wall_id == 'posts'
      redirect_to posts_path
    else
      redirect_to user_path(@post.wall_id)
    end
  end

  def show
    redirect_to posts_path
  end

  def like
    @post = Post.find(params[:id])
    @post.liked_by current_user
    p 'LIKE FIRED'
    p @post.get_likes.size
    p 'LIKES ABOVE'
  end

  def unlike
    @post = Post.find(params[:id])
    @post.unliked_by current_user
    p 'UNLIKE FIRED'
    p @post.get_likes.size
    p 'LIKES ABOVE'
  end

  private

  def post_params
    params.require(:post).permit(:message, :wall_id)
  end
end
