class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.belongs_to :usuario, foreign_key: true
      t.belongs_to :amigo
      t.timestamps
    end
  end
end
