class AddPositionToComics < ActiveRecord::Migration
  def change
    add_column :comics, :position, :integer, unique: true
  end
end
