class CreatePhones < ActiveRecord::Migration[4.2]
  def change
    create_table :phones do |t|
      t.string :ddi
      t.string :ddd
      t.string :number
      t.references :related, index: true, polymorphic: true, null: false
      t.references :phone_carrier
      t.timestamps
    end

    add_foreign_key :phones, :phone_carriers
  end
end
