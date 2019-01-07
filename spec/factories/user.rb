FactoryBot.define do
  factory :user do
    name { "Joao" }
    surname { "Cachoeira" }
    phone { "11999999999" }
    document { "39525850846" }
    sequence(:email) { |n| "some_#{n}@email.com"}
  end
end
