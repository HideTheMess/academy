class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :response_text, :null => false
      t.integer :question_id, :null => false

      t.timestamps
    end

    add_index :choices, :question_id
  end
end
