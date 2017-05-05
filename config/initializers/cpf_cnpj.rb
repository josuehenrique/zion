# -*- encoding : utf-8 -*-
module CpfCnpj
  attr_reader :numero, :numero_formatado

  def initialize(numero)
    @numero = numero
    @numero_formatado = numero
    @match = self.instance_of?(Cpf) ? @numero_formatado =~ CPF_REGEX : @numero_formatado =~ CNPJ_REGEX
    @numero_puro = $1
    @para_verificacao = $2
    @numero_formatado = (@match ? format_number! : nil)
  end

  def to_s
    @numero || ''
  end

  def ==(outro_doc)
    self.numero_formatado == outro_doc.numero_formatado
  end

  # Verifica se o numero possui o formato correto e se
  # constitui um numero de documento valido, dependendo do seu
  # tipo (Cpf ou Cnpj).
  def valido?
    return false unless @match
    verifica_numero
  end

  private

  def verifica_numero
    limpo = @numero_formatado.gsub(/[\.\/-]/, '')
    if self.instance_of? Cpf
      return false if limpo.length != 11
    elsif self.instance_of? Cnpj
      return false if limpo.length != 14
    end
    return false if limpo.scan(/\d/).uniq.length == 1
    primeiro_verificador = primeiro_digito_verificador
    segundo_verificador = segundo_digito_verificador(primeiro_verificador)
    verif = primeiro_verificador + segundo_verificador
    verif == @para_verificacao
  end

  def primeiro_digito_verificador
    array = self.instance_of?(Cpf) ? CPF_ALGS_1 : CNPJ_ALGS_1
    soma = multiplica_e_soma(array, @numero_puro)
    digito_verificador(soma%DIVISOR).to_s
  end

  def segundo_digito_verificador(primeiro_verificador)
    array = self.instance_of?(Cpf) ? CPF_ALGS_2 : CNPJ_ALGS_2
    soma = multiplica_e_soma(array, @numero_puro + primeiro_verificador)
    digito_verificador(soma%DIVISOR).to_s
  end

  def format_number!
    if self.instance_of? Cpf
      @numero_formatado =~ /(\d{3})\.?(\d{3})\.?(\d{3})-?(\d{2})/
      @numero_formatado = "#{$1}.#{$2}.#{$3}-#{$4}"
    else
      @numero_formatado =~ /(\d{2})\.?(\d{3})\.?(\d{3})\/?(\d{4})-?(\d{2})/
      @numero_formatado = "#{$1}.#{$2}.#{$3}/#{$4}-#{$5}"
    end
  end
end
