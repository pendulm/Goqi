class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :name
      t.integer :user_id
      t.integer :friendships_count
    end
  end
end
