class CreateMembers < ActiveRecord::Migration[4.2]
  def change
    create_table :members do |t|
      t.string :name, null: false, limit: 150
      t.string :father_name, null: false, limit: 150
      t.string :mother_name, null: false, limit: 150
      t.references :post, index: true
      t.references :naturalness, index: true
      t.references :job, index: true
      t.date :convert_dt, null: false
      t.date :birth_dt, null: false
      t.string :gender, null: false, limit: 1
      t.string :educational_level, null: false, limit: 2
      t.string :marital_status, null: false, limit: 2
      t.boolean :active, default: true

      t.timestamps
    end

    add_foreign_key :members, :posts
    add_foreign_key :members, :cities, column: :naturalness_id
    add_foreign_key :members, :jobs
  end
end
