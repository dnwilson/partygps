require 'rails_helper'

include Devise::TestHelpers

RSpec.describe Dashboard::EventsController, :type => :controller do

  let(:location){ create(:location) }
  let(:category){ create(:category) }
  let(:event){ create :event, location: location, category: category }
  let(:valid_attributes) { 
    { 
      name:           Faker::Commerce.product_name, 
      photo:          '', 
      start_dt:       Faker::Time.between(Time.now, 60.days.from_now, :night), 
      end_dt:         '', 
      adm:            Faker::Commerce.price,
      description:    'Some description', 
      location_id:    location.id,
      category_id:    category.id
    } 
  }
  let(:new_attributes) { 
    { 
      name:           'Updated Event', 
      photo:          '', 
      recurring_flg:  'false', 
      start_dt:       '09/10/2015', 
      description:    'Some description', 
      location_id:    location.id
    } 
  }

  context "#Admin" do
    login_admin

    describe "GET index" do
      it "assigns all events as @events" do
        get :index, {}
        expect(assigns(:events)).to eq([event])
      end
    end

    describe "GET show" do
      it "assigns the requested event as @event" do
        get :show, {:id => event.to_param}
        expect(assigns(:event)).to eq(event)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        let(:create_event){post :create, {event: valid_attributes}}
        it "creates a new Event" do
          expect{create_event}.to change(Event, :count).by(1)
        end

        it "renders a flash message" do
          expect{create_event}.to change{flash[:success]}
        end

        it "redirects to the created event" do
          expect(create_event).to redirect_to(dashboard_events_path)
        end
      end

      describe "with invalid params" do
        before{ valid_attributes[:category_id] = nil}
        it "re-renders the 'new' template" do
          post :create, {:event => valid_attributes}
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      before(:each) do
        put :update, {:id => event.to_param, event: new_attributes}
      end
      it "updates the requested event as @event" do
        event.reload
        expect(assigns(:event)).to eq(event)
      end
      it "renders a flash message" do
        expect(flash[:success]).to eq("Successfully updated event.")
      end
    end

    describe "DELETE destroy" do
      let(:delete_event){delete :destroy, {:id => @new_event.to_param}}
      
      before{ @new_event = create :event}
      
      it "destroys the requested event" do
        expect{delete_event}.to change(Event, :count).by(-1)
      end

      it "renders a flash message" do
        delete_event
        expect(flash[:notice]).to be_present
      end

      it "redirects to the events list" do
        expect(delete_event).to redirect_to(dashboard_events_path)
      end
    end
  end

  context "#User" do
    login_user

    shared_examples "an unauthorized user" do
      it "redirect_to root and display unauthorized message" do
        expect(response).to redirect_to("http://test.host/")
        expect(flash[:warning]).to eq("You do not have permission to carry out this function")
      end
    end

    describe "GET index" do
      before{ get :index, {} }
      it_behaves_like "an unauthorized user"
    end

    describe "GET show" do
      before do 
        event = create :event
        get :show, {:id => event.to_param} 
      end
      it_behaves_like "an unauthorized user"
    end

    describe "POST create" do
      before{ post :create, {event_listing_form: valid_attributes} }
      it_behaves_like "an unauthorized user"
    end

    describe "DELETE destroy" do
      before{ delete :destroy, {:id => event.to_param} }
      it_behaves_like "an unauthorized user"
    end
  end
end