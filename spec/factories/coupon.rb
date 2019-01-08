FactoryBot.define do
  factory :coupon do
    association :user, factory: :user
    association :order, factory: :order
    sequence(:number) { |n| n }
    series { 0 }
  end
end
