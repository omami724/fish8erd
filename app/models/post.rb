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
  
end
