class AddTeaserToComics < ActiveRecord::Migration
  def change
    add_column :comics, :teaser, :text
  end
end
