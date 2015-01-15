require 'rails_helper'

RSpec.describe Location, :type => :model do
	before{@place = Location.create(name: "Test HQ",
								street_address: "1 Testing Way",
								city_town: "Testville",
								state_parish: "Kingston",
								country: "Jamaica"
								# image: File.new(Rails.root + "spec/fixtures/rails.png")
	)}

	subject{ @place }

	it{should respond_to(:name)}
	it{should respond_to(:street_address)}
	it{should respond_to(:city_town)}
	it{should respond_to(:state_parish)}
	it{should respond_to(:zipcode)}
	it{should respond_to(:country)}
	# it{should respond_to(:image)}
	it{should respond_to(:longitude)}
	it{should respond_to(:latitude)}
	it{should respond_to(:events)}
	it{should be_valid}

	context "when latitude is not present" do
		before{@place.latitude = nil}
		it{should_not be_valid}
	end

	context "when longitude is not present" do
		before{@place.longitude = nil}
		it{should_not be_valid}
	end

	# GPS specs

	# context "when latitude is not present" do
	# 	before{@place.latitude = nil}
	# 	it{should_not be_valid}
	# end

	# context "when longitude is not present" do
	# 	before{@place.longitude = nil}
	# 	it{should_not be_valid}
	# end


end
