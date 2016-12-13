class AddPaymentFeeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment_fee, :integer, default: 0
  end
end
