require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  include Devise::TestHelpers
  
  describe "GET home" do
    it "returns http success" do
      get :home
      expect(response.status).to eq 200
    end
  end

end
