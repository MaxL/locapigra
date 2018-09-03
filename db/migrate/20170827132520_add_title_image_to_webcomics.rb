class AddTitleImageToWebcomics < ActiveRecord::Migration[4.2]
  def change
    add_column :webcomics, :title_image, :string
  end
end
