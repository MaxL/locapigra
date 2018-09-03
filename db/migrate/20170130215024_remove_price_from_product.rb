class RemovePriceFromProduct < ActiveRecord::Migration[4.2]
  def change
    remove_column :products, :price, :decimal
  end
end
