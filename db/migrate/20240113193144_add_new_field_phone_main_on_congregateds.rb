class AddNewFieldPhoneMainOnCongregateds < ActiveRecord::Migration[5.1]
  def change
    add_column :congregateds, :phone_main, :string, limit: 15
  end
end
