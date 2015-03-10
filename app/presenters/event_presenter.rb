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
    if @event.recurring? 
      print_recurring_date_and_adm(@event.listed_type, @event.listed_day, display_price).html_safe
    else
      "<span class='event-date'>#{@event.start_dt.strftime("%b %-d, %Y") + display_price}".html_safe
    end
  end

  def price
    @event.adm? ? h.number_to_currency(@event.adm) : "FREE"
  end

  def path
    if h.current_page?(h.location_path)
      h.event_path
    else
      h.admin_event_path
    end
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

  private
    def print_recurring_date_and_adm(type, day, price)
      day = [EVERY, OTHER].include?(type) ? day : day.pluralize
      "<span class='event-date'>" + position(type) + " " + day + price
    end

    def position(type)
      begin
        case type
        when FIRST
          "1st"
        when SECOND
          "2nd"
        when THIRD
          "3rd"
        when FOURTH
          "4th"
        when OTHER
          "Every " + OTHER
        else
          type
        end
      rescue 
        ""
      end
    end
  
end