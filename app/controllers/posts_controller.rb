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
    @post_address = PostAddress.new
  end

  def create
    @post_address = PostAddress.new(post_params)
    if @post_address.valid?
      @post_address.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def edit
    @post_address = PostAddress.new(id: params[:id])
  end

  def update
    @post_address = PostAddress.new(post_params.merge(id: params[:id]))
    if @post_address.valid?
      @post_address.update
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
    params.require(:post_address).permit(:map_link, :image, :distance, :course, :slope, :traffic, :crowd, :view, :comment, :postal_code, :prefecture_code, :city, :street).merge(user_id: current_user.id)
  end

  def set_search
    params[:q] = { sorts: 'created_at desc' } unless params[:q].present?
    @q = Post.ransack(params[:q])
  end
end
