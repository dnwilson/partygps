# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    name "MyString"
    image "MyString"
    street_address "MyString"
    city_town "MyString"
    state_parish "MyString"
    zipcode "MyString"
    country "MyString"
    latitude 1.5
    longitude 1.5
  end
end
