class AddPaymentChoicesToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :payment_choice, index: true, foreign_key: true
  end
end
