class ChangeUserAddFieldActive < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :active, :boolean, default: true, null: false
    add_index :users, :active
  end
end
