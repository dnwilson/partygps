require 'rails_helper'

RSpec.describe Event, :type => :model do
  
  before do 
    @event = Event.create(name:         Faker::Company.catch_phrase,
                          location:     create(:location),
                          photo:        File.new(Rails.root + "spec/fixtures/rails.png"),
                          start_dt:     DateTime.tomorrow,
                          description:  "Some random rambings",
                          adm:          15.00,
                          category:     Category.create!(name: "Regular"))
  end

  subject{@event}

  it{should respond_to(:name)}
  it{should respond_to(:location_id)}
  it{should respond_to(:category_id)}
  it{should respond_to(:photo)}
  it{should respond_to(:start_dt)}
  it{should respond_to(:end_dt)}
  it{should respond_to(:description)}
  it{should respond_to(:adm)}
  it{should respond_to(:location)}
  it{should respond_to(:listed_type)}
  it{should respond_to(:listed_day)}
  it{should respond_to(:listed_month)}
  it{should respond_to(:location)}
  it{should respond_to(:category)}
  it{should validate_presence_of(:location_id)}
  it{should validate_presence_of(:category_id)}
  it{should validate_presence_of(:name)}
  it{should validate_length_of(:name)}
  it{should be_valid}

end
