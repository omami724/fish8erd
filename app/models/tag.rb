class Tag < ApplicationRecord
    # belongs_to :postandtag
    has_many :postandtags, dependent: :destroy
    has_many :posts, through: :postandtags
end
