# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :location do
    name            "Test HQ"
    street_address  "1 Testing Way"
    city_town       "Testville"
    state_parish    "Kingston"
    country         "Jamaica"
  end
end
