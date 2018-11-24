class InsertAllBrazilianStates < ActiveRecord::Migration[4.2]
  def change
    timestamp = Time.now.to_s(:db)
    execute("
      INSERT INTO states  (id, name, acronym, country_id, created_at, updated_at) VALUES
                            (1, 'Acre', 'AC', 1, '#{timestamp}', '#{timestamp}'),
                            (2, 'Alagoas', 'AL', 1, '#{timestamp}', '#{timestamp}'),
                            (3, 'Amazonas', 'AM', 1, '#{timestamp}', '#{timestamp}'),
                            (4, 'Amapá', 'AP', 1, '#{timestamp}', '#{timestamp}'),
                            (5, 'Bahia', 'BA', 1, '#{timestamp}', '#{timestamp}'),
                            (6, 'Ceará', 'CE', 1, '#{timestamp}', '#{timestamp}'),
                            (7, 'Distrito Federal', 'DF', 1, '#{timestamp}', '#{timestamp}'),
                            (8, 'Espírito Santo', 'ES', 1, '#{timestamp}', '#{timestamp}'),
                            (9, 'Goiás', 'GO', 1, '#{timestamp}', '#{timestamp}'),
                            (10, 'Maranhão', 'MA', 1, '#{timestamp}', '#{timestamp}'),
                            (11, 'Minas Gerais', 'MG', 1, '#{timestamp}', '#{timestamp}'),
                            (12, 'Mato Grosso do Sul', 'MS', 1, '#{timestamp}', '#{timestamp}'),
                            (13, 'Mato Grosso', 'MT', 1, '#{timestamp}', '#{timestamp}'),
                            (14, 'Pará', 'PA', 1, '#{timestamp}', '#{timestamp}'),
                            (15, 'Paraíba', 'PB', 1, '#{timestamp}', '#{timestamp}'),
                            (16, 'Pernambuco', 'PE', 1, '#{timestamp}', '#{timestamp}'),
                            (17, 'Piauí', 'PI', 1, '#{timestamp}', '#{timestamp}'),
                            (18, 'Paraná', 'PR', 1, '#{timestamp}', '#{timestamp}'),
                            (19, 'Rio de Janeiro', 'RJ',1, '#{timestamp}', '#{timestamp}'),
                            (20, 'Rio Grande do Norte', 'RN',1, '#{timestamp}', '#{timestamp}'),
                            (21, 'Rondônia', 'RO', 1, '#{timestamp}', '#{timestamp}'),
                            (22, 'Roraima', 'RR', 1, '#{timestamp}', '#{timestamp}'),
                            (23, 'Rio Grande do Sul', 'RS', 1, '#{timestamp}', '#{timestamp}'),
                            (24, 'Santa Catarina', 'SC', 1, '#{timestamp}', '#{timestamp}'),
                            (25, 'Sergipe', 'SE', 1, '#{timestamp}', '#{timestamp}'),
                            (26, 'São Paulo', 'SP', 1, '#{timestamp}', '#{timestamp}'),
                            (27, 'Tocantins', 'TO', 1, '#{timestamp}', '#{timestamp}');
      ")
  end
end
