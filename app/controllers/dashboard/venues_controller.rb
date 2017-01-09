class Dashboard::VenuesController < Dashboard::BaseController
  before_action :set_venue, only: [:show, :edit, :update, :destroy]
  before_action :google_map, only: [:show, :index]
  before_filter :verify_admin
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

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      flash[:success] = "Successfully created venue."
      redirect_to dashboard_venues_path
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @venue.update_attributes(venue_params)
      flash[:success] = "Successfully updated venue."
      redirect_to dashboard_venues_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    if @venue.destroy
      flash[:notice] = "Successfully deleted venue."
      redirect_to dashboard_venues_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find(params[:id])
    end

    def venue_params
      params.require(:venue).permit(:name, :street_address, :street_address2, :city_town, :state_parish, :zipcode,
                                    :country, :description, :photo )
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
