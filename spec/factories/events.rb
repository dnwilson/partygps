# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    location
    category
    name            Forgery::LoremIpsum.words(2)
    photo           File.new(Rails.root + "spec/fixtures/rails.png")
    start_dt        Forgery::Date.date(future: true, max_delta: 365)
    description     Forgery::LoremIpsum.paragraphs(1)
    adm             15.00
  end
end
