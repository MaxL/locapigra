class AddActiveToPaymentChoice < ActiveRecord::Migration[4.2]
  def change
    add_column :payment_choices, :active, :boolean
  end
end
