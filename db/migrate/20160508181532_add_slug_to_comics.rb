class AddSlugToComics < ActiveRecord::Migration
  def change
    add_column :comics, :slug, :string
  end
end
