# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Category.destroy_all
Event.destroy_all
Location.destroy_all

User.create!(first_name: "Admin", last_name:"Admin", email: "admin@pgps.com", username: "admin", password: "foobar123", password_confirmation: "foobar123", role: "admin")
User.create!(first_name: "Test", last_name:"User", email: "tester@pgps.com",username: "tester", password: "foobar123", password_confirmation: "foobar123", role: "user")
p "Created #{User.count} users"

EVENT_TYPE.each do |category|
  Category.create!(name: category)
end
p "Created #{Category.count} event categories"

l1 = Location.create!(name: "The Quad", street_address: "20-22 Trinidad Terrace", state_parish: "Kingston", country: "Jamaica")
l2 = Location.create!(name: "Cuddyz", latitude: 18.006621, longitude: -76.789662)
l3 = Location.create!(name: "Fiction", latitude: 18.022129, longitude: -76.797266)
l4 = Location.create!(name: "Bacchanal Jamaica Mas Camp", latitude: 18.0013483, longitude: -76.7778559)
l5 = Location.create!(name: "Sugarman's Beach", state_parish: "Portmore", country: "Jamaica")
l6 = Location.create!(name: "Hellshire Beach", state_parish: "Portmore", country: "Jamaica")
l7 = Location.create!(name: "V Club", state_parish: "Portmore", country: "Jamaica")
l8 = Location.create!(name: "Tracks & Records", latitude: 18.02191, longitude: -76.79769)
l9 = Location.create!(name: "Mr Tires", latitude: 18.001708, longitude: -76.817799)
l10 = Location.create!(name: "Oneil's Place", street_address: "33 Hagley Park Rd", state_parish: "Kingston", country: "Jamaica")
l11 = Location.create!(name: "Tripple Century", latitude: 18.006275, longitude: -76.787357)
l12 = Location.create!(name: "Margaritaville", street_address: "23-25 Coconut Dr", city_town: "Montego Bay", state_parish: "St. James", country: "Jamaica")
p "Created #{Location.count} locations"

# Event.create!()