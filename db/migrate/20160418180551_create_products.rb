class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :name
      t.text :description
      t.decimal :price, precision: 12, scale: 3
      t.integer :taxrate
      t.decimal :weight, precision: 12, scale: 3
      t.string :meta_title
      t.text :meta_description
      t.integer :quantity
      t.string :package
      t.string :cover_image
      t.datetime :release_date
      t.string :language
      t.boolean :active

      t.timestamps null: false
    end
  end
end
