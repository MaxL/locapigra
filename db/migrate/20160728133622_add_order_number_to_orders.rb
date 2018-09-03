class AddOrderNumberToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :order_number, :string
  end
end
