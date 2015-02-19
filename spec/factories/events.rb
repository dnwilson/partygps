# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    location
    category
    name            Forgery::LoremIpsum.words(2)
    photo           File.new(Rails.root + "spec/fixtures/rails.png")
    start_dt        DateTime.tomorrow
    description     Forgery::LoremIpsum.paragraphs(1)
    adm             15.00
  end
end
