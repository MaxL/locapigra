class AddPositionToProducts < ActiveRecord::Migration
  def change
    add_column :products, :position, :integer, unique: true
  end
end
