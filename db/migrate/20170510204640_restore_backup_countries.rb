class RestoreBackupCountries < ActiveRecord::Migration[4.2]
  def change
    execute <<-SQL
      TRUNCATE TABLE public.countries
      RESTART IDENTITY
      CASCADE;

      INSERT INTO countries VALUES
        (1,'Brasil','BR',true,'2015-08-03 14:55:15','2015-08-03 14:55:15'),
        (2,'Guiné-Bissau','GB',true,'2015-08-18 13:24:34','2015-08-18 13:24:34'),
        (3,'Uruguai','UY',true,'2015-08-18 13:32:28','2015-08-18 13:32:28');
    SQL
  end
end
