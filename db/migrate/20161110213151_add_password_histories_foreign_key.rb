class AddPasswordHistoriesForeignKey < ActiveRecord::Migration
  def change
    add_foreign_key :user_password_histories, :users
  end
end
