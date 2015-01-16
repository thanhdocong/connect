# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "password",
             password_confirmation: "password",
             admin: true)
User.create!(name:  "Example User 2",
             email: "example2@railstutorial.org",
             password:              "password",
             password_confirmation: "password",
             admin: true)

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
#
users = User.order(:created_at).take(6)
# loop 50 time
50.times do

  title = Faker::Lorem.sentence(5)
  body = Faker::Lorem.sentence(9)
  users.each { |user| user.entries.create!(title: title,body: body,date_post: Time.zone.now) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

users = User.order(:created_at).take(6)
entries = Entry.order(:created_at).take(6)
# loop 50 time
50.times do
  content = Faker::Lorem.sentence(5)
  entries.each { |entry| 
    users.each{|user|
    entry.comments.create!(content: content,user_id: user.id) 
  }
}
end