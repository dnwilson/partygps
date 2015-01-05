require 'rails_helper'

RSpec.describe Place, :type => :model do
	before{@place = Place.create(name: "Some Place",
								street_address: "1 Testing Way",
								city_town: "Testville",
								state_parish: "New York",
								zipcode: "10001",
								country: "USA"
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

	context "when name is not present" do
		before{@place.name = nil}
		it{should_not be_valid}
	end

	context "when street address is not present" do
		before{@place.street_address = nil}
		it{should_not be_valid}
	end

	context "when state or parish is not present" do
		before{@place.state_parish = nil}
		it{should_not be_valid}
	end

	context "when country is not present" do
		before{@place.country = nil}
		it{should_not be_valid}
	end


end
