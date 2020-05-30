class CreateInventories < ActiveRecord::Migration[5.1]
  def change
    create_table :inventories do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.text :observations
      t.boolean :active, default: true, null: false
      t.timestamps
    end
  end
end
