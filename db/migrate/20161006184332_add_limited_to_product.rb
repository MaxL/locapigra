class AddLimitedToProduct < ActiveRecord::Migration
  def change
    add_column :products, :limited, :boolean
  end
end
