class AddNewFieldPhoneOtherOnCongregateds < ActiveRecord::Migration[5.1]
  def change
    add_column :congregateds, :phone_other, :string, limit: 15
  end
end
