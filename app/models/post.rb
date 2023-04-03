class Post < ApplicationRecord
  has_many :postandtags, dependent: :destroy
  has_many :tags, through: :postandtags
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

def save_tags(tags)
    # タグをスペース区切りで分割し配列にする
    #   連続した空白も対応するので、最後の“+”がポイント
    tag_list = tags.split(/[[:blank:]]+/)

    # 自分自身に関連づいたタグを取得する
    current_tags = self.tags.pluck(:name)

    # (1) 元々自分に紐付いていたタグと投稿されたタグの差分を抽出
    #   -- 記事更新時に削除されたタグ
    old_tags = current_tags - tag_list

    # (2) 投稿されたタグと元々自分に紐付いていたタグの差分を抽出
    #   -- 新規に追加されたタグ
    new_tags = tag_list - current_tags

    # tag_mapsテーブルから、(1)のタグを削除
    #   tagsテーブルから該当のタグを探し出して削除する
    old_tags.each do |old|
      # tag_mapsテーブルにあるpost_idとtag_idを削除
      #   後続のfind_byでtag_idを検索
      self.tags.delete Tag.find_by(name: old)
    end

    # tagsテーブルから(2)のタグを探して、tag_mapsテーブルにtag_idを追加する
    new_tags.each do |new|
      # 条件のレコードを初めの1件を取得し1件もなければ作成する
      # find_or_create_by : https://railsdoc.com/page/find_or_create_by
      new_post_tag = Tag.find_or_create_by(name: new)

      # tag_mapsテーブルにpost_idとtag_idを保存
      #   配列追加のようにレコードを渡すことで新規レコード作成が可能
      self.tags << new_post_tag
    end

  end

end
