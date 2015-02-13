class EventListingForm
  include ActiveModel::Model 
  

  # delegate :name, :photo, :recurring_flg, :start_dt, :end_dt, :adm, :description, :location_id, to: :event
  # delegate :listed_day, :listed_month, :listed_type, :category_id, to: :listing
  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates_presence_of :location_id, :category_id, :listed_day, :listed_type
  # validate :valid_start_dt
  validate :presence_of_date_or_category

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
  
  def submit
    setup_listing
    if valid?
      persist!
      true
    else
      false
    end
  end

  def persisted?
    false
  end

  # Validations

  def presence_of_date_or_category
    if start_dt.present?
      errors.add(:start_dt, "cannot be in the past") unless DateTime.parse(self.start_dt) >= DateTime.now rescue false
    else
      errors.add(:start_dt, "must be entered unless this is a recurring event") unless category_id.present? rescue errors.add(:start_dt, "must be entered unless this is a recuring event")
    end
  end

  private
    def persist!
      @event   = Event.new(name: name, photo: photo, start_dt: start_dt, adm: adm,recurring_flg: recurring_flg, description: description,location_id: location_id)
      @listing = @event.build_listing(listed_type: listed_type, listed_day: listed_day, listed_month: listed_month, category_id: category_id)
      @event.save
      @listing.save
    end

    def set_recurring
      self.recurring_flg = recurring_flg.eql?("true") ? true : false
    end

    def setup_listing
      set_recurring
      if recurring_flg == true
        category = Category.find(category_id).name
        self.start_dt = nil
        self.end_dt = nil
        case category
        when Event::WEEKLY
          self.listed_month = nil
          self.listed_type = EVERY
        when Event::MONTHLY
          self.listed_month = nil
        end
      else
        check_date
      end
    end

    def check_date
      begin
        self.start_dt      = start_dt.to_datetime
        self.listed_day    = start_dt.to_datetime.strftime("%A")
        self.listed_type   = Event::REG
        self.listed_month  = start_dt.to_datetime.strftime("%B")
        self.category_id   = Category.where(name: Event::REG).first.id
      rescue 
        errors.add(:start_dt, "must be entered unless this is a recurring event")
      end
    end
end