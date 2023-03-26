class Post < ApplicationRecord
  has_many :postandtags
  has_many :comments, dependent: :destroy
  has_one_attached :image
  belongs_to :user
  has_many :likes, dependent: :destroy
  
  with_options presence: true do
   validates :title
   validates :text
   validates :image
  end
  
  def self.get_fish_image
    (image.attached?) ? image : ''
  end
  
  def liked_by?(user)
    likes.exists?(user_id: user&.id)
  end
  
  def self.looks(search, word)
      if search == "perfect_match"
        @posts = Post.where("title LIKE?","#{word}")
      elsif search == "forward_match"
        @posts = Post.where("title LIKE?","#{word}%")
      elsif search == "backward_match"
        @posts = Post.where("title LIKE?","%#{word}")
      elsif search == "partial_match"
        @posts = Post.where("title LIKE?","%#{word}%")
      else
        @posts = Post.all
      end
  end
  
end
