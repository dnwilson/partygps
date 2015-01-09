class Event < ActiveRecord::Base

	before_save :check_advanced, :check_occurrence

	attr_accessor :occurs, :day_of_occurrence, :day_of_occurrence_mthly, :month_of_occurrence

	belongs_to :location

	SINGLE_EVENT 			= 'SINGLE'
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
	EVENT_OCCURRENCE 						= [SINGLE_EVENT, WEEKLY_EVENT, MONTHLY_EVENT, ANNUALLY_EVENT]
	WEEKLY_OCCURRENCE_DETAILS 	= Date::DAYNAMES.map{|day| day = "Every " + day}
	MONTHLY_OCCURRENCE_DETAILS 	= Date::MONTHNAMES.compact.map{|m| m = "in " + m unless m.nil?}
	
	private
		def set_location(current_location)
			result = Location.where(latitude: current_location.latitude, longitude: current_location.longitude)
			if result.present?
				self.location = result
			else
				new_location = Location.build(city_town: current_location.city, state_parish: current_location.city, country: current_location.country)
			end
		end

		def check_advanced
			unless self.occurrence.present?
				self.occurrence = SINGLE_EVENT
			end
		end

		def check_occurrence
			case occurrence
			when SINGLE_EVENT
				self.occurrence_type = occurrence
			when WEEKLY_EVENT
				self.occurrence_type = occurrence_type
			when MONTHLY_EVENT
				self.occurrence_type = occurs + " " + day_of_occurrence_mthly
				binding.pry
			else
				self.occurrence_type = occurs + " " + day_of_occurrence + " " + month_of_occurrence
				binding.pry
			end
		end
end
