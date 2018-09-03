class AddAddressRefToOrders < ActiveRecord::Migration[4.2]
  def change
    add_reference :orders, :address, index: true
  end
end
