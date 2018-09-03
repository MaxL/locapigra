class AddFeaturedToProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :featured, :boolean
  end
end
