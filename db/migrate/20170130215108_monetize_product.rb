class MonetizeProduct < ActiveRecord::Migration[4.2]
  def change
    add_monetize :products, :price
  end
end
