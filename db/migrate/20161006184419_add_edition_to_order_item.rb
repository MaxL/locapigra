class AddEditionToOrderItem < ActiveRecord::Migration[4.2]
  def change
    add_column :order_items, :edition_number, :int
  end
end
