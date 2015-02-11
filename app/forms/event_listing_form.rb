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

  # def self.model_name
  #   ActiveModel::Name.new(self, nil, "Event")
  # end

  # def listing
  #   @listing || event.build_listing
  # end

  # def event
  #   @event || Event.new
  # end
  # def initialize(user)
  #   @user = user
  # end
  
  def submit(params)
    name          = params[:name]
    photo         = params[:photo]
    start_dt      = params[:start_dt]
    end_dt        = params[:end_dt]
    adm           = params[:adm]
    recurring_flg = params[:recurring_flg].present? ? params[:recurring_flg] : false
    description   = params[:description]
    location_id   = params[:location_id]
    
    if recurring_flg.present? 
      listed_day    = params[:listed_day] 
      listed_type   = params[:listed_type]
      listed_month  = params[:listed_month]
      category_id   = params[:category_id]
    else
      listed_day    = params[:start_dt].to_datetime.strftime("%A")
      listed_type   = Event::REG
      listed_month  = params[:start_dt].to_datetime.strftime("%B")
      category_id   = Category.where(name: Event::REG).first.id 
    end

    # create_event(name, photo, start_dt, end_dt, adm, recurring_flg, description, location_id)
    @event = Event.new( name: name, 
                        photo: photo, 
                        start_dt: start_dt.to_date, 
                        adm: adm,
                        recurring_flg: recurring_flg,
                        description: description,
                        location_id: location_id)
    
    @listing = @event.build_listing(listed_type: listed_type,
                                    listed_day: listed_day,
                                    listed_month: listed_month,
                                    category_id: category_id)

    if valid?
      @event.save
      @listing.save
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
end