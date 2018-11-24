class AddDefaultValueOnSecretPhraseAndPasswordReminder < ActiveRecord::Migration[4.2]
  def change
    change_column :users, :secret_phrase, :string, limit: 30, default: 'default'
    change_column :users, :password_reminder, :string, limit: 150, default: 'default'
  end
end
