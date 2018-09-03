class AddSlugToComics < ActiveRecord::Migration[4.2]
  def change
    add_column :comics, :slug, :string
  end
end
