class AddSlugToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :slug, :string
  end
end
