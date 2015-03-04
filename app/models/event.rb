class Event < ActiveRecord::Base

	include PgSearch

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

	belongs_to :location
	belongs_to :category

	before_save :setup_category

	validates :name, presence: true, length: { minimum: 2, maximum: 30 }, uniqueness: {case_sensitive: false}
  validates_presence_of :location_id, :category_id
  validates_presence_of :listed_day, if: :recurring?
  validate :date_format, unless: :recurring?
  validate :presence_of_date_or_category, :check_date_format
  validates :start_dt, date: {on_or_after: DateTime.now}

  serialize :listed_day

	mount_uploader :photo, ImageUploader

  scope :weekly,          -> { includes(:category, :location).where(categories: {name: WEEKLY}).sort_by{ |e| DAYS[e.listed_day.parameterize.to_sym] } }
  scope :monthly,         -> { includes(:category, :location).where(categories: {name: MONTHLY}) }
  scope :annual,          -> { includes(:category, :location).where(categories: {name: ANNUAL}) }
  scope :live,            -> { includes(:category, :location).where('events.start_dt >= ? AND events.start_dt <= ? OR events.category_id != ? AND events.listed_day = ?', 
                                Date.today.to_time, DateTime.tomorrow, Category.where(name: REG).first.id, DateTime.now.strftime("%A")) }
  scope :upcoming,        -> { includes(:category, :location).where('events.start_dt >= ? OR events.category_id != ? AND events.listed_day = ?', 
                                Date.today.to_time, Category.where(name: REG).first.id, DateTime.now.strftime("%A")).order("events.start_dt ASC NULLS FIRST")}
  # -> { includes(:location).happening_now || where('events.listed_day IN (?)', [DateTime.now.strftime("%A"), DateTime.tomorrow.strftime("%A"), 2.days.from_now.strftime("%A")] ) }
  scope :happening_on,    -> (day){ includes(:category, :location).where(listed_day: day) }
	
  def location_name
		location.name
	end

	def location_address
		location.address
	end

	def address
		[location.street_address, location.city_town, location.state_parish]
	end

	def occurs_once?
  	true unless recurring?
  end

  def recurring?
    true unless self.try(:category).name.eql?(REG) rescue false
  end

  def nearby_events
    location.nearbys(1) && Event.happening_now
  end

	private
		def presence_of_date_or_category
	    if start_dt.present?
	      errors.add(:start_dt, "cannot be in the past") unless self.start_dt >= DateTime.now rescue false
	    else
	      errors.add(:start_dt, "must be entered unless this is a recurring event") unless category_id.present? rescue errors.add(:start_dt, "must be entered unless this is a recuring event")
	    end
	  end

    def check_date_format
			self.errors[:start_dt] << "must be a valid date" unless DateTime.parse(self.start_dt) rescue false
		end

    def setup_category
      if recurring?
        self.start_dt = nil
        self.end_dt = nil
        # self.listed_day = listed_day.delete!(listed_day.last)
      end
      case category.name
      when REG
      	self.listed_day    = start_dt.to_datetime.strftime("%A")
        self.listed_type   = REG
        self.listed_month  = start_dt.to_datetime.strftime("%B")
      when WEEKLY
        self.listed_month = nil
        self.listed_type = EVERY
      when MONTHLY
        self.listed_month = nil
      end
    end

	  def date_format
	  	Rails.logger.debug errors.add(:start_dt, "cannot be in the past") unless self.start_dt >= DateTime.now rescue false
	    errors.add(:start_dt, "cannot be in the past") unless self.start_dt >= DateTime.now rescue false
	  end

end
