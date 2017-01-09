class VenuesController < ApplicationController
  before_action :set_venue, only: [:show]
  before_action :google_map, only: [:show, :index]
  load_and_authorize_resource

  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.all
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find(params[:id])
    end

    def google_map
      @hash = Gmaps4rails.build_markers(@venue) do |venue, marker|
        marker.lat venue.latitude
        marker.lng venue.longitude
        marker.title venue.name
        marker.infowindow venue.name
      end
    end
end
