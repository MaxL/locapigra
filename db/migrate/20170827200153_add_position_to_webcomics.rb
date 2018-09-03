class AddPositionToWebcomics < ActiveRecord::Migration[4.2]
  def change
      add_column :webcomics, :position, :integer
  end
end
