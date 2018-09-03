class AddEmailToAddress < ActiveRecord::Migration[4.2]
  def change
    add_column :addresses, :email, :string
  end
end
