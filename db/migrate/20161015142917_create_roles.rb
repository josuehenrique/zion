class CreateRoles < ActiveRecord::Migration[4.2]
  def change
    create_table :roles do |t|
      t.integer :related_id, null: false
      t.string :related_type, null: false
      t.integer :permit_id, null: false

      t.timestamps
    end

    add_index :roles, :permit_id
    add_index :roles, :related_id
    add_index :roles, :related_type

    add_foreign_key :roles, :permits
  end
end
