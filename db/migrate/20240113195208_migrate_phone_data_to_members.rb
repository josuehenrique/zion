class MigratePhoneDataToMembers < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
    UPDATE members
      SET phone_main=(SELECT phones.number
        FROM phones
        WHERE phones.related_id = members.id and related_type='Members')
    SQL
  end

  def down
    execute <<-SQL
      DROP FUNCTION IF EXISTS only_last_four_phones() CASCADE;
    SQL
  end
end
