class AddVirtualToProduct < ActiveRecord::Migration
  def change
    add_column :products, :is_virtual, :boolean
    add_column :products, :pp_button, :text
  end
end
