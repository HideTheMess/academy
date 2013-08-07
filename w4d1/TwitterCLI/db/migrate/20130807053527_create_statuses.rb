class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :author_id

      t.timestamps
    end
  end
end
