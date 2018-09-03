class AddIndexToComicsName < ActiveRecord::Migration[4.2]
  def change
    add_index :comics, :name, unique: true
  end
end
