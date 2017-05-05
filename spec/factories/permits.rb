FactoryGirl.define do
  factory :permit, aliases: [:user_permit_update] do
    name 'Atualizar'
    controller 'users'
    action 'update'
    modulus 'administration'
  end
end
