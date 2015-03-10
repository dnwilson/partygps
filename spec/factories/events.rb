# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    location
    category
    sequence(:name)         {Faker::Lorem.word}
    photo                   {File.new(Rails.root + "spec/fixtures/rails.png")}
    start_dt                {Faker::Time.between(Time.now, 60.days.from_now, :night)}
    sequence(:description)  {Faker::Lorem.paragraph(2)}
    adm                     Faker::Commerce.price
  end
end