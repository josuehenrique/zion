class CreateCities < ActiveRecord::Migration[4.2]
  def change
    create_table :cities do |t|
      t.string :name, limit: 150, null: false
      t.references :state, index:true, null: false
      t.boolean :active, default: true

      t.timestamps
    end
    add_foreign_key :cities, :states
  end
end
