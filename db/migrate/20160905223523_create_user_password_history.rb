class CreateUserPasswordHistory < ActiveRecord::Migration[4.2]
  def change
    create_table :user_password_histories do |t|
      t.integer :user_id
      t.string :encrypted_password

      t.timestamps
    end
  end
end
