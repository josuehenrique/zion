class CreateJobs < ActiveRecord::Migration[4.2]
  def change
    create_table :jobs do |t|
        t.string :name, null: false, limit: 150
        t.boolean :active, default: true

        t.timestamps
    end
  end
end
