class AddAdditionaltimestampsToOrder < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :placed_on, :datetime
    add_column :orders, :shipped_on, :datetime
    add_column :orders, :cancelled_on, :datetime
  end
end
