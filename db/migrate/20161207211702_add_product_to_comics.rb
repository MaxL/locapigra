class AddProductToComics < ActiveRecord::Migration[4.2]
  def change
    add_reference :comics, :product, index: true, foreign_key: true
  end
end
