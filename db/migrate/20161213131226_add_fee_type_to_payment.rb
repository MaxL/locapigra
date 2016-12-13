class AddFeeTypeToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :fee_type, :string
  end
end
