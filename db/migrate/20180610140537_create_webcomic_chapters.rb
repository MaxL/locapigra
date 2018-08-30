class CreateWebcomicChapters < ActiveRecord::Migration
  def change
    create_table :webcomic_chapters do |t|
      t.references :webcomic, index: true, foreign_key: true
      t.text :title

      t.timestamps null: false
    end
  end
end
