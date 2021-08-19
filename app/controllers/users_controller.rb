class UsersController < ApplicationController
  before_action :user_find
  before_action :authenticate_user!, except: :show
  before_action :move_to_index, except: :show

  def show
    @posts = @user.posts.order(created_at: :DESC)
  end

  def edit; end

  def update
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_find
    @user = User.find(params[:id])
  end

  def move_to_index
    redirect_to root_path if current_user.id != @user.id
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :last_name, :first_name,
                                 :last_name_reading, :first_name_reading, :birthday)
  end
end
