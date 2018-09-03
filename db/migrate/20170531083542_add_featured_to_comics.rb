class AddFeaturedToComics < ActiveRecord::Migration[4.2]
  def change
    add_column :comics, :featured, :boolean
  end
end
