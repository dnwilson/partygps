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
    display_price = "</span><span class='separator'><i class='fa fa-circle'></i></span><span class='event-adm'>" + "Adm: " + price + "</span>"
    case @event.category.name
    when WEEKLY
      date = "<span class='event-date'>" + @event.listed_type + " " + @event.listed_day + display_price
    when MONTHLY
      date =  "<span class='event-date'>" + "Every " + @event.listed_type + " " + @event.listed_day + display_price
    when ANNUAL
      date = "<span class='event-date'>" + "Every " + @event.listed_type + " " + @event.listed_day + display_price
    else
      date = "<span class='event-date'>" + @event.start_dt.strftime("%b %-d, %Y") + display_price
    end
    date.html_safe
  end

  def price
    @event.adm? ? h.number_to_currency(@event.adm) : "FREE"
  end

  def photo(size)
    photo = @event.photo? ? @event.photo.send(size)  : "default-#{size}.svg" 
    h.image_tag(photo)
  end

  def short_date
    @event.start_dt.strftime("%b %-d")
  end

  def long_date
    @event.start_dt.strftime("%a. %B %-d, %Y")
  end
  
end