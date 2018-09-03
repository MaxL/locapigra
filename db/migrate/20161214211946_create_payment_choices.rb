class CreatePaymentChoices < ActiveRecord::Migration[4.2]
  def change
    create_table :payment_choices do |t|
      t.string :name
      t.text :description
      t.integer :fee
      t.string :fee_kind

      t.timestamps null: false
    end
  end
end
