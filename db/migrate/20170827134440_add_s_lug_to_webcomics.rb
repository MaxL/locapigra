class AddSLugToWebcomics < ActiveRecord::Migration
  def change
    add_column :webcomics, :slug, :string
  end
end
