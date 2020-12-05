class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :friend
    end

    add_foreign_key :friendships, :users, column: :friend_id
  end
end
