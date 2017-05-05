FactoryGirl.define do
  factory :user, aliases: [:administrator] do
    avatar { File.new("#{Rails.root}/spec/fixtures/images/test.jpg") }
    email 'teste@hotmail.com'
    password '124356'
    locked false
    admin true
    name 'Josué'
    secret_phrase 'JoSué123'

    factory :user_peter do
      name 'Pedro Augusto'
      email 'peter@gmail.com'
      admin false
    end
  end
end
