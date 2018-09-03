class AddLimitedToProduct < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :limited, :boolean
  end
end
