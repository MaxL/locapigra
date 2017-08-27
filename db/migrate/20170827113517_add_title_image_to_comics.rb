class AddTitleImageToComics < ActiveRecord::Migration
  def change
    add_column :comics, :title_image, :string
  end
end
