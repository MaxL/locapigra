class AddStatusToSubscribers < ActiveRecord::Migration[5.2]
  def change
    add_column :subscribers, :status, :boolean, default: false
  end
end
