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
	multisearchable against: [:name, :description, :occurrence_type]

	before_save :check_advanced, :check_occurrence

	attr_accessor :occurs, :day_of_occurrence, :day_of_occurrence_mthly, :month_of_occurrence

	belongs_to :location

	mount_uploader :photo, ImageUploader

	ONE_TIME_EVENT 		= 'ONE TIME'
	WEEKLY_EVENT 			= 'WEEKLY'
	BI_WEEKLY_EVENT 	= 'BI-WEEKLY'
	BI_MONTHLY_EVENT	= 'BI-MONTHLY'
	MONTHLY_EVENT 		= 'MONTHLY'
	ANNUALLY_EVENT 		= "ANNUAL"

	OTHER		= "Every Other"
	FIRST		= "Every First"
	SECOND	= "Every Second"
	THIRD		= "Every Third"
	FOURTH	= "Every Fourth"
	LAST		= "Every Last"

	INTERMITTENT_OCCURRENCE 		= [FIRST, SECOND, THIRD, FOURTH, LAST, OTHER]
	EVENT_OCCURRENCE 						= [ONE_TIME_EVENT, WEEKLY_EVENT, MONTHLY_EVENT, ANNUALLY_EVENT]
	WEEKLY_OCCURRENCE_DETAILS 	= Date::DAYNAMES.map{|day| day = "Every " + day}
	MONTHLY_OCCURRENCE_DETAILS 	= Date::MONTHNAMES.compact.map{|m| m = "in " + m unless m.nil?}
	
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
		occurrence_type.eql?(ONE_TIME_EVENT)
	end

	def short_date
		date.strftime("%b %-d")
	end

	def long_date
		date.strftime("%a. %B %-d, %Y")
	end

	def self.on_this_date(event_date)
		where(date: event_date)
	end

	private
		# def set_location(current_location)
		# 	result = Location.where(latitude: current_location.latitude, longitude: current_location.longitude)
		# 	if result.present?
		# 		self.location = result
		# 	else
		# 		new_location = Location.build(city_town: current_location.city, state_parish: current_location.city, country: current_location.country)
		# 	end
		# end

		def check_advanced
			unless self.occurrence.present?
				self.occurrence = ONE_TIME_EVENT
			end
		end

		def check_occurrence
			case occurrence
			when ONE_TIME_EVENT
				self.occurrence_type = occurrence
			when WEEKLY_EVENT
				self.occurrence_type = occurrence_type
			when MONTHLY_EVENT
				self.occurrence_type = occurs + " " + day_of_occurrence_mthly
			else
				self.occurrence_type = occurs + " " + day_of_occurrence + " " + month_of_occurrence
			end
		end
end
