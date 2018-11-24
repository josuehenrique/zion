class AddFieldNameInUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :name, :string, limit: 150

    add_index :users, :name

    execute <<-SQL
      UPDATE  users
      SET name = 'Default'
    SQL

    change_column :users, :name, :string, limit: 150, null: false
  end
end
