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
	has_one :listing, dependent: :destroy 

	mount_uploader :photo, ImageUploader

	REG 			= "Regular"
	WEEKLY 	 	= "Weekly"
	BI_WEEKLY	= "Bi-Weekly"
	MONTHLY 	= "Monthly"
	ANNUAL 		= "Annual"
	EVENT_TYPE = [WEEKLY, MONTHLY, ANNUAL]

	def location_name
		location.name
	end

	def location_address
		location.address
	end

	def address
		[location.street_address, location.city_town, location.state_parish]
	end

	# def display_date
 #    if @event.recurring_flg?
 #      @event.start_dt.strftime("%b %-d, %Y")
 #    else
 #      @event.listing.category.name
 #    end
 #  end

	# def occurs_once?
	# 	listing.category.name.eql?(REG) || listing.category.name.nil?
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

	private


end
