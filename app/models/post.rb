class Post < ApplicationRecord
  has_many :postandtags
  has_many :comments
  
  with_options presence: true do
   validates :title
   validates :text
   validates :image
  end
end
