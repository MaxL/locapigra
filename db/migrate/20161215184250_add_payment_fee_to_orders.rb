class AddPaymentFeeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment_fee, :int
  end
end
