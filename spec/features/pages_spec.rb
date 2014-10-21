require "rails_helper"

describe PagesController do 

	subject{page}

	feature 'home page' do
		
		let(:user)  { FactoryGirl.create(:user) }
		let(:admin) { FactoryGirl.create(:admin) }

		before(:each) do
			visit root_path
		end

		context 'when not logged in' do
			it { is_expected.to have_link "login" }
			it { is_expected.to have_link "signup" }
			it { is_expected.to have_link "about" }
			it { is_expected.to have_link "contact" }
		end
	end 
end