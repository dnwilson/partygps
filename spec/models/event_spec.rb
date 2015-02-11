require 'rails_helper'

RSpec.describe Event, :type => :model do
  before{@event = Event.create(name: "Some Event",
                              location_id: 1,
                              photo:       File.new(Rails.root + "spec/fixtures/rails.png"),
                              event_date:  Date.tomorrow.strftime("%m/%d/%Y"),
                              description: "Some random rambings",
                              adm:         15.00)}

  subject{@event}

  it{should respond_to(:name)}
  it{should respond_to(:location_id)}
  it{should respond_to(:listing_id)}
  it{should respond_to(:photo)}
  it{should respond_to(:event_date)}
  it{should respond_to(:description)}
  it{should respond_to(:adm)}
  it{should respond_to(:location)}
  it{should respond_to(:listing)}
  it{should be_valid}

  describe "name" do
    context "when nil" do
      before{@event.name = nil}
      it{should_not be_valid}
    end
    context "when less than 2 characters" do
      before{@event.name = "I"}
      it{should_not be_valid}
    end
    context "when more than 30 characters" do
      before{@event.name = Forgery::LoremIpsum.characters(31)}
      it{should_not be_valid}
    end
  end

  describe "when date_time is in the past" do
    before{ @event.event_date = Date.yesterday }
    it{should_not be_valid}
  end
end
