class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_hash
      t.string :session_token

      t.timestamps
    end

    add_index :users, :email
  end
end
