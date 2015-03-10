class LocationsController < ApplicationController
  before_action :set_location, only: [:show]
  before_action :google_map, only: [:show, :index]
  load_and_authorize_resource

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    def google_map
      @hash = Gmaps4rails.build_markers(@location) do |location, marker|
        marker.lat location.latitude
        marker.lng location.longitude
        marker.title location.name
        marker.infowindow location.name
      end
    end
end
