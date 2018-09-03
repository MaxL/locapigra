class AddDefaultQuantityToOrderItems < ActiveRecord::Migration[4.2]
  def change
    change_column :order_items, :quantity, :integer, default: 0
  end
end
