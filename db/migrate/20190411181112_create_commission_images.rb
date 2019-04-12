class CreateCommissionImages < ActiveRecord::Migration[5.2]
  def change
    create_table :commission_images do |t|
      t.string :path
      t.integer :position
      t.references :commission, foreign_key: true

      t.timestamps
    end
  end
end
