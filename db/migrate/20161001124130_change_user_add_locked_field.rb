class ChangeUserAddLockedField < ActiveRecord::Migration
  def change
    add_column :users, :locked, :boolean, default: true
  end
end
