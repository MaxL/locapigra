class AddFeaturedToComics < ActiveRecord::Migration
  def change
    add_column :comics, :featured, :boolean
  end
end
