class LikesController < ApplicationController
  before_action :post_find

  def create
    Like.create(user_id: current_user.id, post_id: @post.id)
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, post_id: @post.id)
    @like.destroy
  end

  private

  def post_find
    @post = Post.find(params[:post_id])
  end
end
