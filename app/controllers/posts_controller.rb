class PostsController < ApplicationController
  before_action :post_find, only: %i[edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :move_to_index, only: %i[edit update destroy]

  def index
    @posts = Post.includes(:user).order(created_at: :DESC)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(current_user.id)
  end

  private

  def post_find
    @post = Post.find(params[:id])
  end

  def move_to_index
    redirect_to root_path if current_user.id != @post.user.id
  end

  def post_params
    params.require(:post).permit(:map_link, :distance, :course, :slope, :traffic, :crowd, :view,
                                 :comment, :image).merge(user_id: current_user.id)
  end
end
