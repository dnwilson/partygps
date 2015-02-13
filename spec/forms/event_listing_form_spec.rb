require 'rails_helper'

describe EventListingForm do

  describe "Validations" do

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:location_id) }
    it { is_expected.to validate_presence_of(:category_id) }
    it { is_expected.to validate_presence_of(:listed_type) }
    it { is_expected.to validate_presence_of(:listed_day) }

  end

  describe "#submit" do

    let(:event){ double(Event) }
    let(:listing){ double(Listing) }
    let(:regular){ double("category", id: 1, name: "Regular") }
    let(:weekly){ double("category", id: 2, name: "Weekly") }
    let(:monthly){ double("category", id: 3, name: "Monthly") }
    let(:annual){ double("category", id: 4, name: "Annual") }
    let(:event_hash){ 
      {
        name:           'Some Event', 
        photo:          '', 
        recurring_flg:  'false', 
        start_dt:       '09/09/2015', 
        end_dt:         '', 
        adm:            '500.00',
        description:    'Some description', 
        location_id:    '2', 
        listed_day:     '', 
        listed_month:   '', 
        listed_type:    '', 
        category_id:    ''
      } 
    }

    context "regular" do
      before do
        Category.stub(:where).and_return([regular])
        @event_listing_form = EventListingForm.new(event_hash)
        @event_listing_form.submit
      end

      it { expect(@event_listing_form.start_dt).to eq event_hash[:start_dt].to_datetime }
      it { expect(@event_listing_form.category_id).to eq regular.id }
      it { expect(@event_listing_form.listed_type).to eq Event::REG }
      it { expect(@event_listing_form.listed_day).to eq event_hash[:start_dt].to_datetime.strftime("%A") }
      it { expect(@event_listing_form.listed_month).to eq event_hash[:start_dt].to_datetime.strftime("%B") }
      it { expect(@event_listing_form).to be_valid }
    end

    shared_examples "a recurring event" do 
      context ".recurring_flg" do
        it { expect(@event_listing_form.recurring_flg).to be true }
      end
      context ".start_dt" do
        it { expect(@event_listing_form.start_dt).to be_nil }
      end
      context ".end_dt" do
        it { expect(@event_listing_form.end_dt).to be_nil }
      end
    end

    describe 'weekly' do
      before(:each) do
        Category.stub(:find).and_return(weekly)
        event_hash[:listed_type]    = ''
        event_hash[:listed_day]     = 'Tuesdays'
        event_hash[:listed_month]   = 'August'
        event_hash[:category_id]    = 2 
        event_hash[:recurring_flg]  = 'true'
        event_hash[:start_dt]       = ''
        event_hash[:end_dt]         = ''
        @event_listing_form         = EventListingForm.new(event_hash)
        @event_listing_form.submit
      end

      it_behaves_like 'a recurring event'
      context ".category_id" do
        it { expect(@event_listing_form.category_id).to eq weekly.id }
      end
      context ".listed_type" do
        it { expect(@event_listing_form.listed_type).to be EVERY }
      end
      context ".listed_day" do
        it { expect(@event_listing_form.listed_day).to eq event_hash[:listed_day] } 
      end
      context ".listed_month" do
        it { expect(@event_listing_form.listed_month).to be_nil }       
      end
      it { expect(@event_listing_form).to be_valid }
    end

    describe "monthly" do
      before do
        Category.stub(:find).and_return(monthly)
        event_hash[:recurring_flg]  = 'true'
        event_hash[:start_dt]       = ''
        event_hash[:end_dt]         = ''
        event_hash[:listed_type]    = THIRD
        event_hash[:listed_day]     = 'Wednesdays'
        event_hash[:listed_month]   = 'May'
        event_hash[:category_id]    = 3
        @event_listing_form         = EventListingForm.new(event_hash)
        @event_listing_form.submit
      end

      it_behaves_like 'a recurring event'
      context ".category_id" do
        it { expect(@event_listing_form.category_id).to eq monthly.id }
      end
      context ".listed_type" do
        it { expect(@event_listing_form.listed_type).to be THIRD }
      end
      context ".listed_day" do
        it { expect(@event_listing_form.listed_day).to eq event_hash[:listed_day] } 
      end
      context ".listed_month" do
        it { expect(@event_listing_form.listed_month).to be_nil }       
      end
      it { expect(@event_listing_form).to be_valid }
    end

    describe "annual" do
      before do
        Category.stub(:find).and_return(annual)
        event_hash[:recurring_flg]  = 'true'
        event_hash[:start_dt]       = ''
        event_hash[:end_dt]         = ''
        event_hash[:listed_type]    = LAST
        event_hash[:listed_day]     = 'Saturdays'
        event_hash[:listed_month]   = 'March'
        event_hash[:category_id]    = 4
        @event_listing_form         = EventListingForm.new(event_hash)
        @event_listing_form.submit
      end

      it_behaves_like 'a recurring event'
      context ".category_id" do
        it { expect(@event_listing_form.category_id).to eq annual.id }
      end
      context ".listed_type" do
        it { expect(@event_listing_form.listed_type).to be LAST }
      end
      context ".listed_day" do
        it { expect(@event_listing_form.listed_day).to eq event_hash[:listed_day] } 
      end
      context ".listed_month" do
        it { expect(@event_listing_form.listed_month).to eq 'March' }       
      end
      it { expect(@event_listing_form).to be_valid }
    end
  end
end