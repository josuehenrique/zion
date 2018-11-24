class AddFieldEmailToCongregated < ActiveRecord::Migration[4.2]
  def change
    add_column :congregateds, :email, :string
  end
end
