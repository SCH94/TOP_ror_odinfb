FactoryGirl.define do
  factory :user do
    name { Faker::HarryPotter.character }
    email { Faker::Internet.email }
    password { Faker::Internet.password(8) }
  end

  factory :confirmed_user, :parent => :user do
    after(:create) { |user| user.confirm }
  end
end