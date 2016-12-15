class AddActiveToPaymentChoice < ActiveRecord::Migration
  def change
    add_column :payment_choices, :active, :boolean
  end
end
