class Admin::UsersController < ApplicationController
  def top
  end
  
  def index
    @user = User.all.page(params[:page]).per(10)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(customer_params)
      redirect_to admin_customer_path(@user)
    else
      render :edit
    end
  end
  
  private
    
  def user_params
    params.require(:customer).permit(:email,:last_name,:first_name,:kana_last_name,:kana_first_name,:postal_code,:address,:phone_number,:is_deleted)
  end
end
