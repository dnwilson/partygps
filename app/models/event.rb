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
	# before_save :setup_listing #, if: :occurs_once?

	validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates_presence_of :location_id, :category_id
  validate :date_format, unless: :recurring?
  validate :presence_of_date_or_category, :check_date_format
  validates :start_dt, date: {on_or_after: DateTime.now}
  # validates_presence_of :category_id, :listed_type, :listed_day, :listed_month, if: :recurring?

	mount_uploader :photo, ImageUploader

  scope :weekly,          -> { where('category_id = ?', Category.where(name: WEEKLY).first.id) }
  scope :monthly,         -> { where('category_id = ?', Category.where(name: MONTHLY).first.id) }
  scope :annual,          -> { where('category_id = ?', Category.where(name: ANNUAL).first.id) }
  # scope :happening_now,   -> { where('start_dt = ? OR ', ) }
  # scope :weekly, -> { where(listed_type: WEEKLY) }

	# REG 			= "Regular"
	# WEEKLY 	 	= "Weekly"
	# BI_WEEKLY	= "Bi-Weekly"
	# MONTHLY 	= "Monthly"
	# ANNUAL 		= "Annual"
	# EVENT_TYPE = [WEEKLY, MONTHLY, ANNUAL]

	def location_name
		location.name
	end

	def location_address
		location.address
	end

	def address
		[location.street_address, location.city_town, location.state_parish]
	end

  def self.happening_now
    joins(:category).where('events.start_dt = ?', Date.today)
  end

  def self.on_a(day)
    where(listed_day: day)
  end

	# def display_date
 #    if @event.recurring_flg?
 #      @event.start_dt.strftime("%b %-d, %Y")
 #    else
 #      @event.listing.category.name
 #    end
 #  end

	# def occurs_once?
	# 	binding.pry
	# 	self.try(:category).name.eql?(REG) || self.try(:category).name.nil? rescue true
	# end

	# def recurring?
	# 	true unless occurs_once? 
	# end

	# def build_recurring_event
	# 	case listing.category.name
	# 	when WEEKLY
	# 		self.build_weekly_event
	# 	when BI_WEEKLY || MONTHLY
	# 		self.build_monthly_event
	# 	when ANNUAL
	# 		self.build_annual_event
	# 	end
	# end

	# def display_date_or_category
	# 	if self.occurs_once?
	# 		event_date.strftime("%b %-d, %Y")
	# 	else
	# 		listing.category.name.name
	# 	end
	# end

	# def short_date
	# 	event_date.strftime("%b %-d")
	# end

	# def long_date
	# 	event_date.strftime("%a. %B %-d, %Y")
	# end

	# def self.on_this_date(event_date)
	# 	where(event_date: event_date)
	# end
	# def occurs_once?
 #  	category.name.eql?(REG)
 #  end
  def recurring?
    true unless self.try(:category).name.eql?(REG) rescue false
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
      # self.category_id = Category.where(name: Event::REG).first.id if category_id.nil?
      if recurring?
        self.start_dt = nil
        self.end_dt = nil
        self.listed_day = listed_day.slice!(listed_day.length - 1)
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

    # def setup_regular
    #   begin
    #     self.category_id   = Category.where(name: REG).first.id
    #   rescue 
    #     errors.add(:start_dt, "must be entered unless this is a recurring event")
    #   end
    # end

	  def date_format
	  	Rails.logger.debug "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
	  	Rails.logger.debug errors.add(:start_dt, "cannot be in the past") unless self.start_dt >= DateTime.now rescue false
	    errors.add(:start_dt, "cannot be in the past") unless self.start_dt >= DateTime.now rescue false
	  end

end
