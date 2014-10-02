require 'rails_helper'

RSpec.describe "Pages", :type => :request do
	
	describe "GET /" do

		before(:each) do
			get root_path
		end

		context 'when not logged in' do
			it { is_expected.to respond_with 200 }
		end
	end

end