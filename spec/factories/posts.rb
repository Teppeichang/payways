FactoryBot.define do
  factory :post do
    shop_name { Faker::Restaurant.name }
    explain { Faker::Lorem.word }
    association :user
  end
end
