FactoryGirl.define do
  factory :user_permit do
    user { FactoryGirl.cache(:user_peter) }
    permit { FactoryGirl.cache(:permit) }
  end
end
