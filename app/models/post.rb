class Post < ApplicationRecord
  has_many :postandtags
  has_many :comments, dependent: :destroy
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  
  with_options presence: true do
   validates :title
   validates :text
   validates :image
  end
  
  def self.get_fish_image
    (image.attached?) ? image : ''
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end
