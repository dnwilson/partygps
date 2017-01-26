class Api::V1::EventsController < ApplicationController
  # skip_before_action :check_authentication

  def index
    near_ids = Address.near([params[:latitude], params[:longitude]], 3).map(&:id)
    venue_ids = Venue.includes(:addresses).where(addresses: {id: near_ids}).map(&:id)
    @events = Event.includes(:venue).where(venue_id: venue_ids).order(:start_dt)
    render json: @events, status: :ok
  end



  def show
    @event = Event.includes(:user, :venue).find(params[:id])
    render json: @event
  end

  private

  def event_params
    params.require(:events).permit(:name, :venue_id, :user_id, :street_address, :street_address2,
      :city, :state, :zipcode, :country, :longitude, :latitude)
  end
end
