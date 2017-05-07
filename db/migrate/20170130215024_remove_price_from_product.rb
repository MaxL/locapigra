class RemovePriceFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :price, :decimal
  end
end
