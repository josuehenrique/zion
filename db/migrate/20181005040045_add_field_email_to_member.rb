class AddFieldEmailToMember < ActiveRecord::Migration[4.2]
  def change
    add_column :members, :email, :string
  end
end
