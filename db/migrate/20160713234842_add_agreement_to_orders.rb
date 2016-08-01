class AddAgreementToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :agreement, :boolean
  end
end
