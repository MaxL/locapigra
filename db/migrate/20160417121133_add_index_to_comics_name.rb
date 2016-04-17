class AddIndexToComicsName < ActiveRecord::Migration
  def change
    add_index :comics, :name, unique: true
  end
end
