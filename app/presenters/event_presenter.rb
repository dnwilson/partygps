class EventPresenter

  def initialize(event, template)
    @event = event
    @template = template
  end

  def h
    @template
  end

  def display_date
    if @event.recurring?
      "#{@event.category.name}" 
    else
      @event.start_dt.strftime("%b %-d, %Y")
    end
  end

  def date
    display_price = "</span><span class='separator'><i class='fa fa-circle'></i></span><span class='event-listing-adm'>" + " ADM: " + price + "</span>"
    case @event.category.name
    when WEEKLY
      "<span class='event-listing-date'>" + @event.listed_type + " " + @event.listed_day + display_price
    when MONTHLY
       "<span class='event-listing-date'>" + "Every " + @event.listed_type + " " + @event.listed_day + display_price
    when ANNUAL
      "<span class='event-listing-date'>" + "Every " + @event.listed_type + " " + @event.listed_day + display_price
    else
      "<span class='event-listing-date'>" + @event.start_dt.strftime("%b %-d, %Y") + display_price

    end
  end

  def price
    @event.adm? ? h.number_to_currency(@event.adm) : "FREE"
  end

  def photo
    photo = @event.photo? ? @event.photo.thumb  : 'default.svg' 
    h.image_tag(photo)
  end

  def short_date
    @event.start_dt.strftime("%b %-d")
  end

  def long_date
    @event.start_dt.strftime("%a. %B %-d, %Y")
  end
  
end