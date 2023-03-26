class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :followers, class_name: "Follower", foreign_key: "following_id", dependent: :destroy
  has_many :reverse_of_followers, class_name: "Follower", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :followers, source: :followed
  has_many :followereds, through: :reverse_of_followers, source: :follower
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_one_attached :profile_image
  
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.username = "ゲストユーザー"
    end
  end
  
    
    def follow(user_id)
      followers.create(followed_id: user_id)
    end
  
    def unfollow(user_id)
      followers.find_by(followed_id: user_id).destroy
    end
  
    def following?(user)
      followings.include?(user)
    end
    
    def self.looks(search, word)
      if search == "perfect_match"
        @user = User.where("username LIKE?", "#{word}")
      elsif search == "forward_match"
        @user = User.where("username LIKE?","#{word}%")
      elsif search == "backward_match"
        @user = User.where("username LIKE?","%#{word}")
      elsif search == "partial_match"
        @user = User.where("username LIKE?","%#{word}%")
      else
        @user = User.all
      end
    end

  with_options presence: true do
  validates :username
  validates :email
  validates :password
  end
end