class CreateFollowers < ActiveRecord::Migration[6.1]
  def change
    create_table :followers do |t|

      t.integer :following_id
      t.integer :followed_id
      t.timestamps
    end
  end
end
