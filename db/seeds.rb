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
    password: "test#{n}"
  )
end

User.create(
  name: "Leonard Soai-Van",
  email: "leo@gmail.com",
  password: "test"
)

user = User.find_by(email: "leo@gmail.com")
user.friendships.create(friend_id: 4, accepted: true)
user.received_friendships.create(user_id: 1, accepted: true)