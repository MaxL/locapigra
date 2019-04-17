class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :subscriber, foreign_key: true
      t.references :webcomic, foreign_key: true

      t.timestamps
    end
  end
end
