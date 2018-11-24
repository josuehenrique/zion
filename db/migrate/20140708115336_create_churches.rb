class CreateChurches < ActiveRecord::Migration[4.2][4.2]
  def change
    create_table :churches do |t|
      t.string :name, null: false, limit: 150
      t.references :address, index: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
