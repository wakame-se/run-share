class PostsController < ApplicationController
  before_action :post_find, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[top index show search]
  before_action :move_to_index, only: %i[edit update destroy]
  before_action :set_search, only: :index

  def top; end

  def index
    @posts = @q.result(distinct: true).includes(:user).page(params[:page]).per(5)
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
      redirect_to post_path(@post.id)
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
    redirect_to posts_path if current_user.id != @post.user.id
  end

  def post_params
    params.require(:post).permit(:map_link, :distance, :course, :slope, :traffic, :crowd, :view,
                                 :comment, :image).merge(user_id: current_user.id)
  end

  def set_search
    params[:q] = { sorts: 'created_at desc' } unless params[:q].present?
    @q = Post.ransack(params[:q])
  end
end
