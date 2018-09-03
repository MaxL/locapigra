class CreateWebcomicPages < ActiveRecord::Migration[4.2]
  def change
    create_table :webcomic_pages do |t|
      t.references :webcomic, index: true, foreign_key: true
      t.string :path
      t.integer :page_number

      t.timestamps null: false
    end
  end
end
