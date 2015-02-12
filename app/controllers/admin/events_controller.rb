class Admin::EventsController < Admin::BaseController
  # before_action :set_event, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
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

  def render_snippet
    begin
      snippet = params[:category].eql?('bi-weekly') ? 'monthly' : params[:category]
      # binding.pry
      unless params[:category].eql?('regular') || params[:category].nil?
        # @event = Event.new
        # @event.send("build_#{snippet}_event")
        render partial: "admin/events/#{snippet}", f: @event, layout: nil
      end
    rescue
      render nothing: true
    end
  end

  def new
    @event_listing_form = EventListingForm.new
  end

  def create
    binding.pry
    @event_listing_form = EventListingForm.new(params[:event_listing_form])
    if @event_listing_form.submit
      flash[:notice] = "Successfully created event." 
      redirect_to admin_events_path
    else
      render :action => 'new'
    end
  end

  def edit
    @event_listing = EventListing.submit(event_params)
    # @event.build_weekly_event
    # if @event.recurring? 
    #   @event.build_recurring_event
    # end
  end

  def update
    if @event.update_attributes(event_params)
      flash[:notice] = "Successfully updated event."
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
    # def set_event
    #   @event = Event.find(params[:id])
    # end

    # def set_location
    #   @location = Location.find(params[:event][:location_id])
    # end

    # def event_params
    #   params.require(:event).permit(:name, :photo, :location_id, :start_dt, 
    #                                 :end_dt, :adm, :description, :recurring_flg)
    # end

    # def event_listing_params
    #   params.require(:event).permit( :name, :photo, :recurring_flg, :start_dt, :end_dt, :adm,:description, :location_id, :listed_day, :listed_month, :listed_type, :category_id)
    # end

end