class AddPositionToProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :position, :integer, unique: true
  end
end
