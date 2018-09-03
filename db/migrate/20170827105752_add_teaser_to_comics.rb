class AddTeaserToComics < ActiveRecord::Migration[4.2]
  def change
    add_column :comics, :teaser, :text
  end
end
