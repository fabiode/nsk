FactoryBot.define do
  factory :order do
    association :user, factory: :user
    sequence(:number) { |n| n }
  end
end
