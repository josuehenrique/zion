class CreateShepherds < ActiveRecord::Migration[4.2]
  def change
    create_table :shepherds do |t|
      t.string :name, null: false, limit: 150
      t.references :church, index: true
      t.date :birth_dt, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
