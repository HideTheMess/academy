class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name,         :null => false
      t.string :username,     :null => false
      t.string :password,     :null => false
      t.string :session_token

      t.timestamps
    end

    add_index :users, :session_token
  end
end
