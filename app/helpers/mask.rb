module Mask
  def self.cpf(value)
    value.insert(3, '.').insert(7, '.').insert(11, '-')
  end

  def self.date(value)
    I18n.l value if value
  end

  def self.date_time(value)
    I18n.l value, format: :short if value
  end

  def self.tel(value)
    size = value.size
    if size == 10
      value.insert(0, '(').insert(3, ')').insert(4, ' ').insert(9, '-')
    elsif size == 11
      value.insert(0, '(').insert(3, ')').insert(4, ' ').insert(10, '-')
    end
  end

  def self.cep(value)
    value.insert(2, '.').insert(6, '-')
  end

  def self.cnpj(value)
    value.insert(2, '.').insert(6, '.').insert(10, '/').insert(15, '-')
  end

  def self.real(value)
    Dinheiro.new(value).to_s
  end
end
