class InsertBrazilianCountryInCountries < ActiveRecord::Migration
  def change
    execute("
      INSERT INTO countries  (id, name, acronym, created_at, updated_at) VALUES
                    (1, 'Brasil', 'BR', '#{Time.now.to_s(:db)}', '#{Time.now.to_s(:db)}');
    ")
  end
end
