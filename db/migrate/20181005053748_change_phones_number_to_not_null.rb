class ChangePhonesNumberToNotNull < ActiveRecord::Migration[4.2]
  def change
    change_column_null :phones, :number, false
  end
end
