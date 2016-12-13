class AddPaymentToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :payment, index: true, foreign_key: true
  end
end
