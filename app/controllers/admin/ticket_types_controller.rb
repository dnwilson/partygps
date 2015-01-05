class Admin::TicketTypesController < Admin::BaseController
  before_action :set_ticket_type, only: [:update, :destroy]

  def new
    @ticket_type = TicketType.new
  end

  def show
  	
  end

  def create
    check_ticket_type
    @ticket_type = TicketType.new(ticket_type_params)
    if @ticket_type.save
      flash[:notice] = "#{@ticket_type.name} tickets successfully created for #{@ticket_type.event.name}" 
      redirect_to admin_events_path(@ticket_type.event)
    else
      redirect_to admin_events_path(@ticket_type.event)
    end
  end

  def update
    if @ticket_type.update_attributes(ticket_type_params)
      flash[:notice] = "#{@ticket_type.name} tickets successfully updated for #{@ticket_type.event.name}"
      redirect_to admin_events_path(@ticket_type.event)
    else
      redirect_to admin_events_path(@ticket_type.event)
    end
  end

  def destroy
    ticket_item = @ticket_type.name
    if @ticket_type.destroy
      flash[:notice] = "#{item} successfully deleted."
      redirect_to admin_events_path(@ticket_type.event)
    end
  end

  private
    def set_ticket_type
      @event = TicketType.find(params[:id])
    end

  	def ticket_type_params
  		params.require(:ticket_type).permit(:name, :qty, :price, :event_id)
  	end

    def check_ticket_type
      if @ticket_type = TicketType.where(event_id: params[event_id], name: params[:name]).present?
        flash[:alert] = "Ticket Type already exists. Edit this item instead."
        redirect_to admin_events_path(@ticket_type.event)
      end
    end
end