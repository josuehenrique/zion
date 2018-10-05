class RemoveColumnsDdiDddFromPhones < ActiveRecord::Migration
  def change
    remove_column :phones, :ddi
    remove_column :phones, :ddd
  end
end
