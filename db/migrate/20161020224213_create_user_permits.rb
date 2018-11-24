class CreateUserPermits < ActiveRecord::Migration[4.2]
  def change
    create_table :user_permits do |t|
      t.integer :permit_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :user_permits, :user_id
    add_index :user_permits, :permit_id

    add_foreign_key :user_permits, :users
    add_foreign_key :user_permits, :permits
  end
end
