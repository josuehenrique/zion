class ChangeUserAddFieldPasswordReminder < ActiveRecord::Migration
  def change
    add_column :users, :password_reminder, :string, limit: 150, null: false
  end
end
