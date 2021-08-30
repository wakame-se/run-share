class CommentsController < ApplicationController
  before_action :post_find, only: %i[create destroy]
  before_action :authenticate_user!, only: %i[create destroy]

  def create
    @comment = @post.comments.new(comment_params)
    if @comment.save
      redirect_to post_path(@post.id)
    else
      @comments = @post.comments.includes(:user)
      render post_path(@post.id)
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post.id)
  end

  private
  def post_find
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id)
  end
end
