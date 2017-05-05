class ChangeTypeNumberAddress < ActiveRecord::Migration
  def change
    change_column :addresses, :number, 'integer USING CAST(number AS integer)', default: 0, null: false
  end
end
