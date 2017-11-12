require 'database_cleaner'

DatabaseCleaner.clean_with(:truncation) if Rails.env.development?

5.times do |n|
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

user.friendships.create(friend_id: 4, accepted: true)
friend = User.find(4)

5.times do |n|
  user.posts.create(
    title: Faker::Book.title, 
    body: Faker::VentureBros.quote  
  )
end

3.times do |n|
  friend.posts.create(
    title: Faker::Book.title,
    body: Faker::VentureBros.quote         
  )
end

3.times do |n|
  user.comments.create(
    post_id: 1,
    body: Faker::VentureBros.quote        
  )
end