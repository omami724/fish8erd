class Public::PostsController < ApplicationController
  def new
   @fish = Post.new
   @comment = Comment.new
  end

  def index
   @fish = Post.new
   @fishes = Post.all
  end
  
  def create
    @fish = Post.new(fish_params)
    
    if @fish.save
    #redirect_to '/top'
    flash[:notice]="You have creatad fish successfully."
      redirect_to post_path(@fish)
    else
      @user = current_user
      @fishes = Post.all
      render :index
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @image = Postandtag.new
    @comment = Comment.new
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end
  
  def edit
  end

  def update
  end
  
  private
  def fish_params
    params.require(:post).permit(:title, :text, :image)
  end

end
