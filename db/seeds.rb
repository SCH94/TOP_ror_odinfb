# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |n|
  User.create(
    name: Faker::HarryPotter.character,
    email: "Example#{n}@gmail.com",
    password: "testing#{n}"
  )
end

user = User.create(
  name: "Leonard Soai-Van",
  email: "leo@gmail.com",
  password: "testing"
)

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