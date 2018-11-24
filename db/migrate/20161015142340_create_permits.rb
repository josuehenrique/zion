class CreatePermits < ActiveRecord::Migration[4.2]
  def change
    create_table :permits do |t|
      t.string :name, null: false
      t.string :modulus, null: false
      t.string :controller, null: false
      t.string :action, null: false

      t.timestamps
    end

    add_index :permits, :name
    add_index :permits, :modulus
    add_index :permits, :controller
    add_index :permits, :action
  end
end
