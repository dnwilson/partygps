require "rails_helper"

# include Warden::Test::Helpers
# Warden.test_mode!

# describe "GET 'users/auth/facebook/callback'" do
#   config.extend StubOutExternal
  
#   before(:each) do
#     user = FactoryGirl.create(:user)
#     login_as(user, :scope => :user)
#     get "/users/auth/facebook/callback"
#     request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
#     binding.pry
#   end

#   it "should set user_id" do
#     expect(session[:user_id]).to eq(User.last.id)
#   end

#   it "should redirect to root" do
#     expect(response).to redirect_to root_path
#   end
# end

# describe "GET 'users/auth/failure'" do

#   it "should redirect to root" do
#     get "/auth/failure"
#     expect(response).to redirect_to root_path
#   end
# end