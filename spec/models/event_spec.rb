require 'rails_helper'

RSpec.describe Event, :type => :model do
  before{@event = Event.create(name: "Some Event",
                              location_id: 1,
                              photo: File.new(Rails.root + "spec/fixtures/rails.png"),
                              start_dt: DateTime.tomorrow,
                              description: "Some random rambings",
                              adm: 15.00)}

  subject{@event}

  it{should respond_to(:name)}
  it{should respond_to(:location_id)}
  it{should respond_to(:photo)}
  it{should respond_to(:start_dt)}
  it{should respond_to(:end_dt)}
  it{should respond_to(:description)}
  it{should respond_to(:adm)}
  it{should respond_to(:location)}
  it{should respond_to(:listing)}
  it{should be_valid}
end
