class Public::PostsController < ApplicationController
  def new
   @fish = Post.new
   @comment = Comment.new
  end

  def index
   @fish = Post.new
   @fishes = Post.all.page(params[:page])
  end
  
  def create
    @fish = Post.new(fish_params)
    @fish.user_id = current_user.id
    
    if @fish.save
    #redirect_to '/top'
    flash[:notice]="You have creatad fish successfully."
      redirect_to post_path(@fish)
    else
      @user = current_user
      @fishes = Post.all.page(params[:page])
      render :index
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @image = Postandtag.new
    @comment = Comment.new
  end
  
  def destroy
    Post.find(params[:id]).destroy
    redirect_to posts_path
  end
  
  def edit
   @post = Post.find(params[:id])
   #@user = @book.user
   @fishes = Post.all
  end

  def update
   @post = Post.find(params[:id])
   @post.update(fish_params)
   redirect_to post_path(@post)
  end
  
  private
  def fish_params
    params.require(:post).permit(:title, :text, :image)
  end

end
