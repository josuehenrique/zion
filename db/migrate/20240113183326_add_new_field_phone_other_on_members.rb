class AddNewFieldPhoneOtherOnMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :phone_other, :string, limit: 15
  end
end
