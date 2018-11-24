class CreatePosts < ActiveRecord::Migration[4.2]
  def change
    create_table :posts do |t|
      t.string :name, null: false, limit: 150
      t.string :classification, null: false, limit: 1
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
