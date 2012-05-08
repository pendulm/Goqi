class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :from
      t.integer :to
      t.boolean :status
      t.string :remark_name

      t.timestamps
    end
  end
end
