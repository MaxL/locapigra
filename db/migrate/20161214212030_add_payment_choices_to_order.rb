class AddPaymentChoicesToOrder < ActiveRecord::Migration[4.2]
  def change
    add_reference :orders, :payment_choice, index: true, foreign_key: true
  end
end
