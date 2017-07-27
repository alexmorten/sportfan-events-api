class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags,id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid
      t.string :name

      t.timestamps
    end
    add_index :tags, :name, unique: true
  end
end
