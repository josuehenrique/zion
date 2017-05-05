class CreateCongregateds < ActiveRecord::Migration
  def change
    create_table :congregateds do |t|
      t.string :name, null: false, limit: 150
      t.date :birth_dt, null: false
      t.date :entry_dt, null: false
      t.boolean :baptized, default: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
