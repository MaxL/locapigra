class AddSLugToWebcomics < ActiveRecord::Migration[4.2]
  def change
    add_column :webcomics, :slug, :string
  end
end
