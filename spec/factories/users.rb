# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	sequence(:email)	     {Forgery::Internet.email_address}
  	first_name			       Forgery::Name.first_name
  	last_name			         Forgery::Name.last_name
  	dob 				           20.years.ago
  	address                Forgery::Address.street_address
  	state 				         Forgery::Address.state 
  	city				           Forgery::Address.city 
  	zipcode                Forgery::Address.zip 
  	country			           Forgery::Address.country
  	role                   "user"
    password               "foobar123"
    password_confirmation  "foobar123"

  	factory :admin do
  		role		"admin"
  	end
  end
end
