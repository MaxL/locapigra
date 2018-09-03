class AddVirtualToProduct < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :is_virtual, :boolean
    add_column :products, :pp_button, :text
  end
end
