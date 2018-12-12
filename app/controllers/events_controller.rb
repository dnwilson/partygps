class EventsController < ApplicationController
	before_action :set_event, only: [:show]
  load_and_authorize_resource

  # GET /events
  # GET /events.json
  def index
		near_ids = Address.near("Kingston,Jamaica", 3).map(&:id)
    venue_ids = Venue.includes(:addresses).where(addresses: {id: near_ids}).map(&:id)
    @events = Event.includes(:category, :venue).where(venue_id: venue_ids).order(:start_dt)
    @events = params[:option] ? @events.send(params[:option].downcase) : @events
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end
end
