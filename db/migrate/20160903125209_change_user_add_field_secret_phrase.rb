class ChangeUserAddFieldSecretPhrase < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :secret_phrase, :string, null: false, limit: 30, after: :email
  end
end
