FactoryBot.define do
  factory :comment do
    user
    post
    body "My text"
  end
end
