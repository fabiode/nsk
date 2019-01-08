require Rails.root.join('spec/support/doc_generator.rb')

FactoryBot.define do
  factory :user do
    name { "Joao" }
    surname { "Cachoeira" }
    phone { "11999999999" }
    document { DocGenerator.generate_cpf  }
    sequence(:email) { |n| "some_#{n}@email.com"}
  end
end
