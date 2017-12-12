require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation) if Rails.env.development?

100.times do |n|
  User.new.tap do |user|
    user.name = Faker::HarryPotter.character
    user.email = "Example#{n}@gmail.com"
    user.password = "testing#{n}"
    user.skip_confirmation!
    user.save!
  end
end

user = User.new(
  name: "Tester Example",
  email: "tester@example.com",
  password: "testing"
)
user.skip_confirmation!
user.save!

100.times do |n|
  user.posts.create(
    title: Faker::Book.title, 
    body: Faker::VentureBros.quote  
  )
end

100.times do |n|
  user.comments.create(
    post_id: 1,
    body: Faker::VentureBros.quote        
  )
end

50.times do |n|
  user.friendships.create(
    friend_id: n,
    accepted: true        
  )
end