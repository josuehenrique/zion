class AddTriggerUserPasswords < ActiveRecord::Migration[4.2]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION only_last_four_password_histories() RETURNS TRIGGER AS $BODY$
        BEGIN
          DELETE FROM user_password_histories
          WHERE user_id = NEW.user_id AND id NOT IN (
            SELECT id FROM user_password_histories
            WHERE user_id = NEW.user_id ORDER BY created_at DESC limit 4);
          RETURN NEW;
        END;
      $BODY$ LANGUAGE 'plpgsql';

      CREATE TRIGGER only_last_four_password_histories
        AFTER INSERT ON user_password_histories
        FOR EACH ROW
        EXECUTE PROCEDURE only_last_four_password_histories();
    SQL
  end

  def down
    execute <<-SQL
      DROP FUNCTION IF EXISTS only_last_four_password_histories() CASCADE;
    SQL
  end
end
