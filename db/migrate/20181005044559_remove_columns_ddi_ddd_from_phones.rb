class RemoveColumnsDdiDddFromPhones < ActiveRecord::Migration[4.2]
  def change
    remove_column :phones, :ddi
    remove_column :phones, :ddd
  end
end
