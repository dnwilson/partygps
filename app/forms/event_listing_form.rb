class EventListingForm
  include ActiveModel::Model 
  

  # delegate :name, :photo, :recurring_flg, :start_dt, :end_dt, :adm, :description, :location_id, to: :event
  # delegate :listed_day, :listed_month, :listed_type, :category_id, to: :listing
  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates_presence_of :location_id, :category_id, :listed_type, :listed_day, :listed_month
  validate :valid_start_dt

  attr_accessor(
    :name, 
    :photo, 
    :recurring_flg, 
    :start_dt, 
    :end_dt, 
    :adm,
    :description, 
    :location_id, 
    :listed_day, 
    :listed_month, 
    :listed_type, 
    :category_id
  )

  def create_event
    setup_listing
    @event ||= Event.new( name: name, 
                          photo: photo, 
                          start_dt: start_dt.to_date, 
                          adm: adm,
                          recurring_flg: recurring,
                          description: description,
                          location_id: location_id
                        )
    @listing = @event.build_listing(  listed_type: listed_type,
                                      listed_day: listed_day,
                                      listed_month: listed_month,
                                      category_id: category_id
                                    )
    @event.save
    @listing.save
  end
  
  def submit
    if valid?
      create_event
      true
    else
      false
    end
  end


  def persisted?
    false
  end

  private

  def valid_start_dt
    errors.add(:start_dt, "must be a valid date") unless DateTime.parse(self.start_dt) > DateTime.now rescue false
  end

  def recurring
    self.recurring_flg = recurring_flg.present? ? recurring_flg : false
  end

  def setup_listing
    unless recurring
      listed_day    = listed_day.to_datetime.strftime("%A")
      listed_type   = Event::REG
      listed_month  = listed_month.to_datetime.strftime("%B")
      category_id   = Category.where(name: Event::REG).first.id 
    end
  end
end