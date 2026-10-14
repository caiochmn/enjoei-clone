class CreateStores < ActiveRecord::Migration[8.1]
  def change
    create_table :stores do |t|
      t.references :user, index: { unique: true }, null: false, foreign_key: true
      t.string :name, null: false
      t.string :slug, null: false
      t.text :bio
      t.decimal :rating_average, precision: 3, scale: 2

      t.timestamps
    end
    add_index :stores, :slug, unique: true
  end
end
