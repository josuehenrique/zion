class CreateAddress < ActiveRecord::Migration[4.2]
  def change
    create_table :addresses do |t|
      t.references :city, index: true, null: false
      t.integer :related_id, null: false
      t.string :related_type, null: false
      t.string :street, null: false
      t.string :complement
      t.string :number, null: false, limit: 15
      t.string :district, null: false
      t.string :zipcode, null: false, limit: 8
      t.decimal :lat, precision: 14, scale: 6
      t.decimal :long, precision: 14, scale: 6
      t.string :reference_point, null: false

      t.timestamps
    end

    add_foreign_key :addresses, :cities
    add_index :addresses, [:related_id, :related_type]
    add_index :addresses, [:related_type, :related_id]
  end
end
