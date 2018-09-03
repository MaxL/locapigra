class AddPaymentFeeToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :payment_fee, :int
  end
end
