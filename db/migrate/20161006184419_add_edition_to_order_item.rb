class AddEditionToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :edition_number, :int
  end
end
