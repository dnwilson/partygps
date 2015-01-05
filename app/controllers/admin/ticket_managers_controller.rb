class Admin::TicketManagersController < Admin::BaseController
  before_action :set_ticket_manager, only: [:edit, :update]

  def edit
    @ticket_type = TicketType.new
    if @ticket_manager.ticket_types.present?
      @ticket_types = @ticket_manager.ticket_types
    end
  end

  def update
    @ticket_type = @ticket_manager.ticket_types.build(ticket_type_params)
    if @ticket_type.save
      flash[:notice] = "Successfully created Ticket Type." 
      redirect_to edit_admin_ticket_manager_path
    else
      redirect_to edit_admin_ticket_manager_path
    end
  end

  # def update
  #   if @event.update_attributes(event_params)
  #     flash[:notice] = "Successfully updated event."
  #     redirect_to admin_events_path
  #   else
  #     render :action => 'edit'
  #   end
  # end

  private
    def set_ticket_manager
      @ticket_manager = TicketManager.find(params[:id])
    end
  	def ticket_type_params
  		params.require(:ticket_type).permit(:name, :price, :ticket_manager_id)
  	end
end