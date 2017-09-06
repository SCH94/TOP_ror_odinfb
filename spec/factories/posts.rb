FactoryGirl.define do
  factory :post do
    association :user
    title { Faker::Book.title }
    body { Faker::VentureBros.quote }
  end
end
