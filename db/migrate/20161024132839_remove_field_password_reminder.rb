class RemoveFieldPasswordReminder< ActiveRecord::Migration[4.2]
  def change
    remove_column :users, :password_reminder
  end
end
