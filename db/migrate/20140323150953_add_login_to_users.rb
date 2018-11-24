class AddLoginToUsers < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :users, :login, :string
    add_index :users, :login, unique: true
  end
end
