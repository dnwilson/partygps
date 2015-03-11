require "rails_helper"

include Warden::Test::Helpers
Warden.test_mode!

describe "UserPages" do 

	subject{page}

	feature 'login' do
		
		let(:user)  { User.create(first_name: "John", 
								  last_name: "Doe",
								  email: "johndoe@example.com",
								  password: "test1234",
								  password_confirmation: "test1234") }
		let(:admin) { FactoryGirl.create(:admin) }

		before(:each) do
			create :category
			visit login_path
		end

		context 'when not logged in' do
			it { is_expected.to have_link "login" }
			it { is_expected.to have_link "signup" }
			it { is_expected.to have_link "about" }
			it { is_expected.to have_link "contact" }
			it { is_expected.to have_selector ".registration" }
			it { is_expected.to have_selector "#user_email" }
			it { is_expected.to have_selector "#user_password" }
			it { is_expected.to have_link "Forgot Password?" }
			it { is_expected.to have_link "Find a party now!" }
			it { is_expected.to have_link "Facebook" }
			it { is_expected.to have_link "Google" }
		end

		context "when user is valid" do
			before{valid_user_login}

			it { is_expected.to have_text "#{user.first_name}" }
		end

		context "when user is invalid" do
			before do
				visit login_path
				fill_in "Email", 				with: "someguy@test.com"
				fill_in "Password", 		with: "password"
				click_button "LOGIN"
			end

			it { is_expected.to have_text "Invalid email address or password." }
		end

	end

	feature	"facebook sign in" do
		before do
			create :category
			stub_request(:get, "https://graph.facebook.com/me?access_token=mock_token").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.0'}).
         to_return(:status => 200, :body => "", :headers => {})
			visit login_path
			click_link "Facebook"
		end

		context "when trying to signin with facebook" do
			it { is_expected.to have_text "You are in..!!! Go to edit profile to see the status for the accounts" }
			it { is_expected.to have_text "John" }
		end
	end

	feature "edit" do
		before do
			visit login_path
			fill_in "Email Address", 		with: user.email
			fill_in "Password", 				with: user.password
			click_button "LOGIN"
			visit settings_path
		end
	end
end

def valid_user_login
  visit login_path
  fill_in "Email",        with: user.email
  fill_in "Password",     with: user.password
  click_button "LOGIN"
end
