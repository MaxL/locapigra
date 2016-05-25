class AddReleasedToComics < ActiveRecord::Migration
  def change
    add_column :comics, :released, :boolean
  end
end
