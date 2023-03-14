class Public::UsersController < ApplicationController
  
  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
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

  
end
