class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.references :event, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
    add_index :links, [:event_id,:tag_id], unique: true
  end
end
