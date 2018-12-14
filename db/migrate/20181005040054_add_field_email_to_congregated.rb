class AddFieldEmailToCongregated < ActiveRecord::Migration
  def change
    add_column :congregateds, :email, :string
  end
end
