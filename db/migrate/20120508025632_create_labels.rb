class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :name, null: false
      t.references :user, null: false
      t.integer :friendships_count, default: 0
    end

    change_table :labels do |t|
      t.index [:name, :user_id], unique: true
    end
  end
end
