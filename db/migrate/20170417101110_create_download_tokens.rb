class CreateDownloadTokens < ActiveRecord::Migration[4.2]
  def change
    create_table :download_tokens do |t|
      t.string :token
      t.timestamp :expires_at

      t.timestamps null: false
    end
  end
end
