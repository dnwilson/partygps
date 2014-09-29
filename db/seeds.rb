# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(first_name: "Admin", last_name:"Admin", email: "admin@pgps.com", username: "admin", password: "foobar123", password_confirmation: "foobar123", role: "admin")
User.create!(first_name: "Test", last_name:"User", email: "tester@pgps.com",username: "tester", password: "foobar123", password_confirmation: "foobar123", role: "user")