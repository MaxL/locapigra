class AddTitleImageToWebcomics < ActiveRecord::Migration
  def change
    add_column :webcomics, :title_image, :string
  end
end
