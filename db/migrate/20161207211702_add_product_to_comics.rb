class AddProductToComics < ActiveRecord::Migration
  def change
    add_reference :comics, :product, index: true, foreign_key: true
  end
end
