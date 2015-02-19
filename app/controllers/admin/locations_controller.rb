class Admin::LocationsController < Admin::BaseController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
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

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      flash[:success] = "Successfully created location." 
      redirect_to admin_locations_path
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @location.update_attributes(location_params)
      flash[:success] = "Successfully updated location."
      redirect_to admin_locations_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    if @location.destroy
      flash[:notice] = "Successfully deleted location."
      redirect_to admin_locations_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:name, :street_address, :street_address2, :city_town, :state_parish, :zipcode, 
                                    :country, :description, :photo )
    end
end