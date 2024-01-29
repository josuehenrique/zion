class AddNewFieldPhoneMainOnMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :phone_main, :string, limit: 15
  end

end
