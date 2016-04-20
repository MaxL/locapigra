class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :comic, index: true, foreign_key: true
      t.string :path

      t.timestamps null: false
    end
  end
end
