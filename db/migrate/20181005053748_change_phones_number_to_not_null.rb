class ChangePhonesNumberToNotNull < ActiveRecord::Migration
  def change
    change_column_null :phones, :number, false
  end
end
