class AddTaxToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :tax, :decimal, precision: 12, scale: 3
  end
end
