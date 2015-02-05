# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Event.destroy_all
Location.destroy_all

User.create!(first_name: "Admin", last_name:"Admin", email: "admin@pgps.com", username: "admin", password: "foobar123", password_confirmation: "foobar123", role: "admin")
User.create!(first_name: "Test", last_name:"User", email: "tester@pgps.com",username: "tester", password: "foobar123", password_confirmation: "foobar123", role: "user")
p "Created #{User.count} users"

# Location.create!(name: "The Quad", city_town: "New Kingston", state_parish: "Kingston")
# Location.create!(name: "Cuddy'z", street_address: "Dominica Drive", city_town: "New Kingston", state_parish: "Kingston")
# Location.create!(name: "Fiction", street_address: "67 Constant Spring Rd", city_town: "Kingston 10", state_parish: "Kingston")
# Location.create!(name: "Mass Camp", street_address: "Arthur Wint Drive", city_town: "Kingston", state_parish: "Kingston")
# Location.create!(name: "Sugarman's Beach", street_address: "Hellshire", city_town: "Portmore", state_parish: "St. Catherine")

l1 = Location.create!(name: "The Quad", state_parish: "Kingston", country: "Jamaica")
l2 = Location.create!(name: "Cuddyz", state_parish: "Kingston", country: "Jamaica")
l3 = Location.create!(name: "Fiction", state_parish: "Kingston", country: "Jamaica")
l4 = Location.create!(name: "Mass Camp", state_parish: "Portmore", country: "Jamaica")
l5 = Location.create!(name: "Sugarman's Beach", state_parish: "Portmore", country: "Jamaica")
l6 = Location.create!(name: "Hellshire Beach", state_parish: "Portmore", country: "Jamaica")
l7 = Location.create!(name: "V Club", state_parish: "Kingston", country: "Jamaica")
l8 = Location.create!(name: "Tracks & Records", state_parish: "Kingston", country: "Jamaica")
l9 = Location.create!(name: "Mr Tires", street_address: "Waltham Park Road", state_parish: "Kingston", country: "Jamaica")
l10 = Location.create!(name: "Oneil's Place", state_parish: "Kingston", country: "Jamaica")
l10 = Location.create!(name: "Tripple Century", state_parish: "Kingston", country: "Jamaica")

p "Created #{Location.count} locations"


# Event.create!()