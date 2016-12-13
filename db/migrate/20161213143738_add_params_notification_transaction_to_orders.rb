class AddParamsNotificationTransactionToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :notification_params, :text
    add_column :orders, :transaction_id, :string
  end
end
