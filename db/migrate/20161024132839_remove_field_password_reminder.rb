class RemoveFieldPasswordReminder< ActiveRecord::Migration
  def change
    remove_column :users, :password_reminder
  end
end
