class AddReleasedToComics < ActiveRecord::Migration[4.2]
  def change
    add_column :comics, :released, :boolean
  end
end
