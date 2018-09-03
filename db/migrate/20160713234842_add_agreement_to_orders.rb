class AddAgreementToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :agreement, :boolean
  end
end
