FactoryBot.define do
  factory :user do
    name                  { Faker::Internet.domain_name }
    email                 { Faker::Internet.free_email }
    prefecture_id         { 1 }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
  end
end
