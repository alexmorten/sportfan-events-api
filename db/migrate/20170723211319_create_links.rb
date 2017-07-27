class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links, id: :uuid do |t|
      t.references :event, foreign_key: true, type: :uuid
      t.references :tag, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :links, [:event_id,:tag_id], unique: true
  end
end
