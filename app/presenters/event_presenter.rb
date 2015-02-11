class EventPresenter

  def initialize(event, template)
    @event = event
    @template = template
  end

  def h
    @template
  end

  def display_date
    if @event.recurring_flg?
      @event.listing.category.name
    else
      @event.start_dt.strftime("%b %-d, %Y")
    end
  end

  def photo
    # binding.pry
    photo = @event.photo? ? @event.photo.thumb  : 'default.svg' 
    h.image_tag(photo)
  end
  
end