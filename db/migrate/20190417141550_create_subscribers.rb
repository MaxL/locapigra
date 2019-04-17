class CreateSubscribers < ActiveRecord::Migration[5.2]
  def change
    create_table :subscribers do |t|
      t.string :name
      t.string :email
      t.boolean :confirmed, default: false
      t.string :confirmation_token

      t.timestamps
    end
  end
end
