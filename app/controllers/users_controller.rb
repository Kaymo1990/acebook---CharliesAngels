class UsersController < ApplicationController

  protect_from_forgery

  def show
    @user = User.find(params[:id])
    @posts = Post.all
  end

  def index
    @users = User.all
  end

  def search
    search_query = params[:search].downcase
    if search_query.blank?
      @searched_users = User.all
    else
      @searched_users = User.all.where("lower(firstname) LIKE :search OR lower(lastname) LIKE :search", search: "%#{search_query}%")
    end
  end

  def new
    if logged_in?
      flash[:register_already] = ['you already have an account']
      redirect_to posts_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.create(user_params)
    if @user.save
      log_in(@user)
      # session[:current_user_id] = @user.id
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  @user = User.find(params[:id])
  if @user.update_attributes(user_params)
    redirect_to user_path(@user.id)
    # Handle a successful update.
  else
    render 'edit'
  end
end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :avatar)
  end
end
