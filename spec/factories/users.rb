# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :user do
  	email	                 {Faker::Internet.email}
  	first_name			       Faker::Name.first_name
  	last_name			         Faker::Name.last_name
  	dob 				           20.years.ago
  	address                Faker::Address.street_address
  	# state 				         Faker::Address.state 
  	city				           Faker::Address.city 
  	zipcode                Faker::Address.zip_code
  	country			           Faker::Address.country
  	role                   "user"
    password               "foobar123"
    password_confirmation  "foobar123"

  	factory :admin do
  		role		"admin"
  	end

    factory :super_admin do
      role    "super_admin"
    end
  end
end
