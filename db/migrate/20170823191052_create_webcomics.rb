class CreateWebcomics < ActiveRecord::Migration[4.2]
  def change
    create_table :webcomics do |t|
      t.text :title
      t.text :description

      t.timestamps null: false
    end
  end
end
