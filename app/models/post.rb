class Post < ApplicationRecord
  has_many :postandtags
  has_many :comments, dependent: :destroy
  has_one_attached :image
  
  with_options presence: true do
   validates :title
   validates :text
   validates :image
  end
  
  def self.get_fish_image
    (image.attached?) ? image : ''
  end
  
end
