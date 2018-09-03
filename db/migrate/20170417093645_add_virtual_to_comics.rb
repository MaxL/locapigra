class AddVirtualToComics < ActiveRecord::Migration[4.2]
  def change
    add_column :comics, :is_virtual, :boolean
    add_column :comics, :pp_button, :text
  end
end
