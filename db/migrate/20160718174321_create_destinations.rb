class CreateDestinations < ActiveRecord::Migration[4.2]
  def change
    create_table :destinations do |t|
      t.string :country_code
      t.string :country_name
      t.decimal :shipping_price, precision: 12, scale: 3

      t.timestamps null: false
    end
  end
end
