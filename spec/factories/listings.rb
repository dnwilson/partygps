# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :listing do
    association :category
    assoication :event
    listing_day "MyString"
    listing_month "MyString"
    listing_type "MyString"
  end
end
