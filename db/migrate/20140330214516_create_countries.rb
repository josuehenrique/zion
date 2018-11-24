class CreateCountries < ActiveRecord::Migration[4.2]
  def change
    create_table :countries do |t|
      t.string :name, limit: 60
      t.string :acronym, limit:2
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
