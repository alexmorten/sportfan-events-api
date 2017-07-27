class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups, id: :uuid do|t|
      t.string :name
      t.text :description
      t.string :groupable_type
      t.uuid :groupable_id

      t.timestamps
    end
  end
end
