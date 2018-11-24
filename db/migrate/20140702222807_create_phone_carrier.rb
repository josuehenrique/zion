class CreatePhoneCarrier < ActiveRecord::Migration[4.2]
  def change
    create_table :phone_carriers do |t|
      t.string :name, limit: 20
      t.timestamps
    end
  end
end
