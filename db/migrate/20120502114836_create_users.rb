class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email
      t.string :password_digest
      t.timestamp :signup_time
      t.timestamp :last_visit_time
    end

    change_table :users do |t|
      t.index :email, unique: true
    end

  end
end
