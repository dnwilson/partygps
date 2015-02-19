class Admin::EventsController < Admin::BaseController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  authorize_resource
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  def manager
    @event = Event.find(params[:event_id])
    if @event.ticket_types.present?
      @ticket_types = @event.ticket_types
    else
      @ticket_type = @event.ticket_types.new
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "Successfully created event." 
      redirect_to admin_events_path
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.new(event_params)
  end

  def update
    if @event.update_attributes(event_params)
      flash[:success] = "Successfully updated event."
      redirect_to admin_events_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    if @event.destroy
      flash[:notice] = "Successfully deleted event."
      redirect_to admin_events_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :photo, :location_id, :start_dt, 
                                    :end_dt, :adm, :description, :listed_day, 
                                    :listed_type, :listed_month, :category_id)
    end

    # def event_listing_params
    #   params.require(:event).permit( :name, :photo, :recurring_flg, :start_dt, :end_dt, :adm,:description, :location_id, :listed_day, :listed_month, :listed_type, :category_id)
    # end

end