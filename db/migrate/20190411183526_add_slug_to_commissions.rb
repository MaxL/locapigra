class AddSlugToCommissions < ActiveRecord::Migration[5.2]
  def change
    add_column :commissions, :slug, :string
  end
end
