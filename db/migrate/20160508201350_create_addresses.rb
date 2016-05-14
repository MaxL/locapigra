class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.text :recipient
      t.string :street
      t.string :city
      t.string :zip
      t.string :state
      t.string :country

      t.timestamps null: false
    end
  end
end
