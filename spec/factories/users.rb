FactoryGirl.define do
  factory :user, aliases: [:administrator] do
    avatar { File.new("#{Rails.root}/spec/fixtures/images/test.jpg") }
    email 'teste@hotmail.com'
    password '124356'
    cpf '76727744335'
    locked false
    admin true
    name 'Josué'
    secret_phrase 'JoSué123'

    factory :user_peter do
      name 'Pedro Augusto'
      email 'peter@gmail.com'
      cpf '00461262100'
      admin false
    end
  end
end
