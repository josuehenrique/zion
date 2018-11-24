class ChangeUserAddFieldPasswordReminder < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :password_reminder, :string, limit: 150, null: false
  end
end
