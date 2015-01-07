class Event < ActiveRecord::Base

	before_save :check_advanced

	belongs_to :location

	SINGLE_EVENT = 'SINGLE'
	WEEKLY_EVENT = 'WEEKLY'
	BI_WEEKLY_EVENT = 'BI-WEEKLY'
	BI_MONTHLY_EVENT = 'BI-MONTHLY'
	MONTHLY_EVENT = 'MONTHLY'
	ANNUALLY_EVENT = "ANNUAL"
	EVENT_OCCURRENCE = [SINGLE_EVENT, WEEKLY_EVENT, BI_WEEKLY_EVENT, BI_MONTHLY_EVENT, MONTHLY_EVENT, ANNUALLY_EVENT]

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
end
