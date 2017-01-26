# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

p "Deleting records"
Tagging.delete_all
Tag.delete_all
Address.delete_all
User.delete_all
Venue.delete_all
Category.delete_all
Event.delete_all

admin = User.create!(first_name: "Admin", last_name: "Admin", username: "admin", email: "admin@admin.com",
  password: "password", password_confirmation: "password")
admin.addresses.create!(street_address: "17a Dominica Drive", street_address2: "",
  city: "New Kingston", state: "Kingston", zipcode: "5", country: "Jamaica", primary_flg: true)
fire_stick_hq = Venue.create!(name: "Fire Stick HQ")
fire_stick_hq.addresses.create!(street_address: "30 York Ave",
  street_address2: "Off Hagley Park Road", city: "Cockburn Pen", state: "Kingston", zipcode: "11",
  country: "Jamaica", primary_flg: true)
our_yard = Venue.create!(name: "Our Yard")
our_yard.addresses.create!(street_address: "10 Balmoral Ave", street_address2: "Off Half Way Tree Road",
  city: "", state: "Kingston", zipcode: "10", country: "Jamaica", primary_flg: true)
wappinz_hq = Venue.create!(name: "Wappinz HQ")
wappinz_hq.addresses.create!(street_address: "Mahoe Drive", street_address2: "Off Hagley Park Road",
  city: "Cockburn Pen", state: "Kingston", zipcode: "11", country: "Jamaica", primary_flg: true)
oniel_place = Venue.create!(name: "Oniel's Place")
oniel_place.addresses.create!(street_address: "33 Hagley Park Road", street_address2: "", city: "",
  state: "Kingston", zipcode: "", country: "Jamaica", primary_flg: true)
the_dock = Venue.create!(name: "The Dock")
the_dock.addresses.create!(street_address: "3B Port Royal Street", street_address2: "",
  city: "Downtown Kingston", state: "Kingston", zipcode: "", country: "Jamaica", primary_flg: true)

reg = Category.create!(name: "Regular")
Category.create!(name: "Weekly")
Category.create!(name: "Monthly")
Category.create!(name: "Annual")

20.times do |n|
  p "Creating regular events..."
  year = Faker::Number.between(2012, 2017)
  admin.events.create!(name: "#{Faker::App.name} #{n}",
                       photo: File.new("factory/flyers/flyer_#{year}.png"),
                       venue: Venue.limit(1).order("RANDOM()").first,
                       category: reg,
                       tag_list: Faker::Lorem.words.join(","),
                       description: Faker::Lorem.paragraph(2),
                       start_dt: Faker::Date.between(DateTime.now, 6.months.from_now),
                       adm: Faker::Number.decimal(2)
                      )
  p "Created event # #{n}"
end
