class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :name
      t.string :description
      t.integer :pages
      t.string :cover
      t.string :cover_image
      t.string :color
      t.string :dimensions

      t.timestamps null: false
    end
  end
end
