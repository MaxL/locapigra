class AddVirtualToComics < ActiveRecord::Migration
  def change
    add_column :comics, :is_virtual, :boolean
    add_column :comics, :pp_button, :text
  end
end
