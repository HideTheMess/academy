class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string  :title,     null: false
      t.string  :url,       null: false
      t.string  :body
      t.integer :author_id, null: false

      t.timestamps
    end

    add_index :links, :author_id
  end
end
