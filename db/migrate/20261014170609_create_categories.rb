class CreateCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.references :parent, foreign_key: { to_table: :categories }
      t.integer :position, null: false, default: 0

      t.timestamps
    end
    add_index :categories, [ :parent_id, :slug ], unique: true
  end
end
