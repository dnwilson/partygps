require 'rails_helper'

RSpec.describe User, :type => :model do
	before{@user = User.create(email: "jdoe@test.com",
								first_name: "John",
								last_name: "Doe",
								address: "1 Testing Way",
								address2: "Suit 2000",
								city: "Testville",
								state: "New York",
								zipcode: "10001",
								country: "USA",
								password: "foobar123",
								password_confirmation: "foobar123",
								role: 'user'
		)}

	subject{ @user }

	it{should respond_to(:email)}
	it{should respond_to(:first_name)}
	it{should respond_to(:last_name)}
	it{should respond_to(:username)}
	it{should respond_to(:address)}
	it{should respond_to(:address2)}
	it{should respond_to(:city)}
	it{should respond_to(:state)}
	it{should respond_to(:zipcode)}
	it{should respond_to(:country)}
	it{should respond_to(:password)}
	it{should respond_to(:password_confirmation)}
	it{should respond_to(:role)}

	it{should be_valid}


	describe "when address is not present" do
		before{@user.email = nil}
		it{should_not be_valid}
	end

	describe "when first name is not present" do
		before{@user.first_name = nil}
		it{should_not be_valid}
	end

	describe "when last name is not present" do
		before{@user.last_name = nil}
		it{should_not be_valid}
	end

	describe "when password is less than 8 characters" do
		before{@user.password = "foobar"}
		it{should_not be_valid}
	end

	describe "when role is not present" do
		before{@user.role = nil}
		it{should_not be_valid}
	end
end
