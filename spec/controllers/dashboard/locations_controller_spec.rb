require 'rails_helper'

include Devise::TestHelpers

RSpec.describe Dashboard::LocationsController, :type => :controller do

  let(:location){ create(:location) }
  let(:valid_attributes) { 
    { 
      name:           "Test HQ",
      street_address: "1 Testing Way",
      city_town:      "Testville",
      state_parish:   "Kingston",
      country:        "Jamaica"
    } 
  }

  context "#Admin" do
    login_admin

    describe "GET index" do
      it "assigns all locations as @locations" do
        get :index, {}
        expect(assigns(:locations)).to eq([location])
      end
    end

    describe "GET show" do
      it "assigns the requested location as @location" do
        get :show, {:id => location.to_param}
        expect(assigns(:location)).to eq(location)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        let(:create_location){post :create, {location: valid_attributes}}
        it "creates a new Location" do
          expect{create_location}.to change(Location, :count).by(1)
        end

        it "renders a flash message" do
          expect{create_location}.to change{flash[:success]}
        end

        it "redirects to the created location" do
          expect(create_location).to redirect_to(dashboard_locations_path)
        end
      end

      describe "with invalid params" do
        before{ valid_attributes[:country] = nil}
        it "re-renders the 'new' template" do
          post :create, {location: valid_attributes}
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      before(:each) do
        valid_attributes[:name] = "New Name"
        put :update, {:id => location.to_param, location: valid_attributes}
      end
      it "updates the requested location as @location" do
        location.reload
        expect(assigns(:location)).to eq(location)
      end
      it "renders a flash message" do
        expect(flash[:success]).to eq("Successfully updated location.")
      end
    end

    describe "DELETE destroy" do
      let(:delete_location){delete :destroy, {:id => @new_location.to_param}}
      
      before{ @new_location = create :location}
      
      it "destroys the requested location" do
        expect{delete_location}.to change(Location, :count).by(-1)
      end

      it "renders a flash message" do
        delete_location
        expect(flash[:notice]).to be_present
      end

      it "redirects to the locations list" do
        expect(delete_location).to redirect_to(dashboard_locations_path)
      end
    end
  end

  context "#User" do
    login_user

    shared_examples "an unauthorized user" do
      it "redirect_to root and display unauthorized message" do
        expect(response).to redirect_to(root_path)
        expect(flash[:warning]).to eq("You do not have permission to carry out this function")
      end
    end

    describe "GET index" do
      before{ get :index, {} }
      it_behaves_like "an unauthorized user"
    end

    describe "GET show" do
      before do 
        location = create :location
        get :show, {:id => location.to_param} 
      end
      it_behaves_like "an unauthorized user"
    end

    describe "POST create" do
      before{ post :create, {location_listing_form: valid_attributes} }
      it_behaves_like "an unauthorized user"
    end

    describe "DELETE destroy" do
      before{ delete :destroy, {:id => location.to_param} }
      it_behaves_like "an unauthorized user"
    end
  end
end