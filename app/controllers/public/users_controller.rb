class Public::UsersController < ApplicationController
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
  def show
    @users = User.all
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = @user.posts.build
  end

  def edit
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      redirect_to user_path(@user)
    end 
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to my_page_users_path, notice: "変更の保存しました"
    else
      render :edit
    end
  end

  def confirm_withdraw
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find_by(email: params[:email])
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  def index
    @users = User.all
  end

end
