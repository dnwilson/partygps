class EventsController < ApplicationController
	before_action :set_event, only: [:show]
  load_and_authorize_resource

  # GET /events
  # GET /events.json
  def index
    if params[:option]
      @events = Event.send(params[:option].downcase)
      # case params[:option]
      # when WEEKLY
      #   @events = Event.weekly.sort_by{ |e| DAYS[e.listed_day.parameterize.to_sym]}
      # when MONTHLY
      #   @events = Event.monthly.sort_by{ |e| DAYS[e.listed_day.parameterize.to_sym]}
      # when ANNUAL
      #   @events = Event.annual.sort_by{ |e| DAYS[e.listed_day.parameterize.to_sym]}
      # when "Live"
      #   @events = Event.live
      # when "Recurring"
      #   @events = Event.recurring
      # end
    else
      @events = Event.upcoming
    end
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
