class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :from, null: false
      t.integer :to, null: false
      t.boolean :status, default: false, null: false
      t.string :remark_name

      t.timestamps
    end

    change_table :friendships do |t|
      t.index [:from, :to], unique: true
    end

  end
end
