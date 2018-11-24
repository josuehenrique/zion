class AddPhoneType < ActiveRecord::Migration[4.2]
  def change
    add_column :phones, :phone_type, :string, limit: 11, null: false, default: 'residential'
  end
end
