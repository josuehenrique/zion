class CreateStates < ActiveRecord::Migration[4.2]
  def change
    create_table :states do |t|
      t.string :name, limit: 60
      t.string :acronym, limit: 2
      t.references :country, index: true, null: false
      t.boolean :active, default: true

      t.timestamps
    end

    add_foreign_key :states, :countries
  end
end
