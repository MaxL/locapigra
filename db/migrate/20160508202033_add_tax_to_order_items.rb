class AddTaxToOrderItems < ActiveRecord::Migration[4.2]
  def change
    add_column :order_items, :tax, :decimal, precision: 12, scale: 3
  end
end
