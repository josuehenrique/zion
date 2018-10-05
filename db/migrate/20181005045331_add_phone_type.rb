class AddPhoneType < ActiveRecord::Migration
  def change
    add_column :phones, :phone_type, :string, limit: 10, null: false, default: 'residential'
  end
end
