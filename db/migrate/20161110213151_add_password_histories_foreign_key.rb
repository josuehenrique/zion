class AddPasswordHistoriesForeignKey < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :user_password_histories, :users
  end
end
