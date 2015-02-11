# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    association :location
    association :listing
    name        "Some Event"
    photo       File.new(Rails.root + "spec/fixtures/rails.png")
    event_date  Date.tomorrow.strftime("%m/%d/%Y")
    description "Some random rambings"
    adm         15.00
  end
end
