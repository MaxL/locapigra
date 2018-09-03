class AddTitleImageToComics < ActiveRecord::Migration[4.2]
  def change
    add_column :comics, :title_image, :string
  end
end
