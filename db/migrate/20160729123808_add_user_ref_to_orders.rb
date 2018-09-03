class AddUserRefToOrders < ActiveRecord::Migration[4.2]
  def change
    add_reference :orders, :user, index: true
  end
end
