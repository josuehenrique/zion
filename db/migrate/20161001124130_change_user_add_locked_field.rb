class ChangeUserAddLockedField < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :locked, :boolean, default: true
  end
end
