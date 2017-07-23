class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.references :event, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
