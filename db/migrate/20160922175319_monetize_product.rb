class MonetizeProduct < ActiveRecord::Migration
  def change
    add_monetize :products, :price
  end
end
