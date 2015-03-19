require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  
  include Devise::TestHelpers

  before{ @event = create(:event, start_dt: Time.now.utc.end_of_day) }
  
  # shared_examples "an index page" do |option = nil|
  #   before do
  #     @event = create(:event, start_dt: Time.now.utc.end_of_day)
  #   end

  #   it "assigns all events as @events" do
  #     get :index, {option: option}
  #     expect(assigns(:events)).to eq([@event])
  #   end

  #   it "renders page successfully" do
  #     get :index, {option: option}
  #     expect(response.status).to eq 200
  #   end

  #   it "uses the correct template" do
  #     get :index, {option: option}
  #     expect(response).to render_template("index")
  #   end
  # end

  # describe "GET index" do
  #   describe "when option is not present or nil" do
  #     it_behaves_like "an index page"
  #   end

  #   describe "when option = live" do
  #     it_behaves_like "an index page", "Live"
  #   end

  #   describe "when option = upcoming" do
  #     it_behaves_like "an index page", "upcoming"
  #   end

  #   describe "when option = recurring" do
  #     before do
  #       @event = create(:event, start_dt: Time.now.utc.end_of_day)
  #       get :index, {option: "recurring"}
  #     end

  #     it "assigns all events as @events" do
  #       expect(assigns(:events)).to eq([])
  #     end

  #     it "renders page successfully" do
  #       expect(response.status).to eq 200
  #     end

  #     it "uses the correct template" do
  #       expect(response).to render_template("index")
  #     end
  #   end
  # end

  describe "GET show" do
    it "assigns the requested event as @event" do
      get :show, {:id => @event.to_param}
      expect(assigns(:event)).to eq(@event)
    end
  end
end