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
								password_confirmation: "foobar123"
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

	# it "should assign a username if one is not present" do
	# 	before{ @user.save }
	# 	.to change{ @user.username }
	# end

	# it "should assign a role if is one is not present" do
	# 	expect{ @user.save }.to change{ @user.role }
	# end

	# it "should assign a username if one is not present" do
	# 	before{@user.username = nil}
	# 	@user.should_receive(:username)
	# 	@user.save
	# end

	describe "after creation" do
		before do
			@user.save
			@user = @user.reload
		end

		it "should have the correct role" do
			expect(@user.role).to eq "user"
		end

		it "should have the correct username" do
			expect(@user.username).to eq "user_1"
		end
	end
end
