class CreateFriendshipsLables < ActiveRecord::Migration
  def change
    create_table :friendships_labels, id: false do |t|
      t.references :friendship, null: false
      t.references :label, null: false
    end
  end
end
