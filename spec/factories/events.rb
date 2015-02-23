# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    location
    category
    sequence(:name)         {Faker::Company.catch_phrase}
    photo                   File.new(Rails.root + "spec/fixtures/rails.png")
    start_dt                {Faker::Time.between(Time.now, 60.days.from_now, :night)}
    sequence(:description)  {Faker::Lorem.sentences(2)}
    adm                     rand(15..2500)
  end
end

