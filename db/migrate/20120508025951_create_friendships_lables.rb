class CreateFriendshipsLables < ActiveRecord::Migration
  def change
    create_table :friendships_labels do |t|
      t.integer :friendship_id
      t.integer :label_id
    end
  end
end
