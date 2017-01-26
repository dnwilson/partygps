class Event < ActiveRecord::Base

	include PgSearch
	include Taggable

	# Set up search
	# To remove search documents for this class
	# PgSearch::Document.delete_all(searchable_type: "Event")
	# To build seach documents for this class
	# rake pg_search:multisearch:rebuild[Event] or PgSearch::Document.rebuild(Event)
	# pg_search_scope :search_full_text,
	# 								:against => [[:name, 'A'], [:description, 'B']],
	# 								:using => [ :tsearch => [:dictionary => "simple", :prefix => true]],
	# 								:ignoring => [:accents]
	multisearchable against: [:name, :description]

	belongs_to :user
	belongs_to :venue
	belongs_to :category

	before_save :setup_category

	validates :name, presence: true, length: { minimum: 2, maximum: 30 }, uniqueness: {case_sensitive: false}
  validates_presence_of :venue_id, :category_id
  validates_presence_of :listed_day, if: :recurring?
  validate :date_format, unless: :recurring?
  validate :presence_of_date_or_category, :check_date_format
  validates :start_dt, date: {on_or_after: DateTime.now}

	mount_uploader :photo, ImageUploader

  scope :weekly,        -> { includes(:category, :venue).where(categories: {name: WEEKLY}) }
  scope :monthly,       -> { includes(:category, :venue).where(categories: {name: MONTHLY}) }
  scope :annual,        -> { includes(:category, :venue).where(categories: {name: ANNUAL}) }
  scope :future_events, -> { includes(:category, :venue).where(events: {start_dt: [Time.now..1.month.from_now]}) }
  scope :recurring_on_this_day,  -> { includes(:category, :venue).where.not(categories: {name: REG})
                                  .where(events: {listed_day: Time.now.strftime("%A"), listed_month: [nil, Time.now.strftime("%B")]}) }
  scope :live,          -> { todays_recurring | future_events.where(start_dt: [Time.now.beginning_of_day..Time.now.end_of_day]).order('events.start_dt ASC')}
  scope :happening_on,  -> (day){ includes(:category, :venue).where(listed_day: day) }


	# For tags
	def self.tagged_with(name)
		Tag.find_by_name!(name).articles
	end


  def self.recurring
    events = Event.includes(:category, :venue)
         .where.not(categories: {name: REG})

    events.sort_by{ |e| [ DAYS[e.listed_day.parameterize.to_sym], LISTED_ORDER[e.listed_type.parameterize.to_sym] ] }
  end

  def self.upcoming
    this_weeks_recurring.sort_by{ |e| [ DAYS[e.listed_day.parameterize.to_sym], LISTED_ORDER[e.listed_type.parameterize.to_sym], e.name ] } | future_events.where(start_dt: [Time.now..1.week.from_now])
  end

  def self.todays_recurring
    list = []
    recurring_on_this_day.each do |e|
      list << e if Time.now.week_of_month.eql?(LISTED_ORDER[e.listed_type.parameterize.to_sym]) | e.listed_type.eql?(EVERY)
    end
    list
  end

  def self.this_weeks_recurring
    list = []
    recurring.each do |e|
      list << e if e.recurs_this_week?
    end
    list
  end

  def venue_name
		venue.name
	end

	def venue_address
		venue.address
	end

	def address
		[venue.street_address, venue.city_town, venue.state_parish]
	end

	def occurs_once?
  	true unless recurring?
  end

  def recurring?
    true unless self.try(:category).name.eql?(REG) rescue false
  end

  # Checks if a recurring event happens this week and returns on events on days
  # that have not passed in the week
  def recurs_this_week?
   (Time.now.week_of_month.eql?(LISTED_ORDER[listed_type.downcase.to_sym]) || listed_type.eql?(EVERY)) &&
   Time.now.wday <= DAYS[listed_day.downcase.to_sym]
  end

  def nearby_events
    venue.nearbys(1) && Event.happening_now
  end

	private
		def presence_of_date_or_category
	    if start_dt.present?
	      errors.add(:start_dt, "cannot be in the past") unless self.start_dt >= Time.now rescue false
	    else
	      errors.add(:start_dt, "must be entered unless this is a recurring event") unless category_id.present? rescue errors.add(:start_dt, "must be entered unless this is a recuring event")
	    end
	  end

    def check_date_format
			self.errors[:start_dt] << "must be a valid date" unless Time.parse(self.start_dt) rescue false
		end

    def setup_category
      if recurring?
        self.start_dt = nil
        self.end_dt = nil
      end
      case category.name
      when REG
      	self.listed_day    = start_dt.to_time.strftime("%A")
        self.listed_type   = REG
        self.listed_month  = start_dt.to_time.strftime("%B")
      when WEEKLY
        self.listed_month = nil
        self.listed_type = EVERY
      when MONTHLY
        self.listed_month = nil
      end
    end

	  def date_format
	    errors.add(:start_dt, "cannot be in the past") unless self.start_dt >= Time.now rescue false
	  end

end
