class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index; end

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

  private

  def post_params
    params.require(:post).permit(:map_link, :distance, :course, :slope, :traffic, :crowd, :view,
                                 :comment, :image).merge(user_id: current_user.id)
  end
end
