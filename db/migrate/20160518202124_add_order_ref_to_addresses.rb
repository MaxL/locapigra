class AddOrderRefToAddresses < ActiveRecord::Migration[4.2]
  def change
    add_reference :addresses, :order, index: true
  end
end
