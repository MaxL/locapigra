class AddPositionToComics < ActiveRecord::Migration[4.2]
  def change
    add_column :comics, :position, :integer, unique: true
  end
end
