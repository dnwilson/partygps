require 'rails_helper'

# include Devise::TestHelpers

RSpec.describe Dashboard::BaseController, :type => :controller do
	context "#Guest" do
		before{ get :show }

		it "redirect_to root and display unauthorized message" do
      expect(response).to redirect_to(login_path)
      expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
    end
	end
end