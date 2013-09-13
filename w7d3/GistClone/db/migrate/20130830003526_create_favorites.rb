class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :gist_id

      t.timestamps
    end

    add_index :favorites, :user_id
    add_index :favorites, :gist_id
    add_index :favorites, [:user_id, :gist_id], :unique => true
  end
end
