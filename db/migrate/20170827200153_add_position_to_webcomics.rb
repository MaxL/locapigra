class AddPositionToWebcomics < ActiveRecord::Migration
  def change
      add_column :webcomics, :position, :integer
  end
end
