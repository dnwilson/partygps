class Event < ActiveRecord::Base

	belongs_to :location

	private
		def set_location(current_location)
			result = Location.where(latitude: current_location.latitude, longitude: current_location.longitude)
			if result.present?
				self.location = result
			else
				new_location = Location.build(city_town: current_location.city, state_parish: current_location.city, country: current_location.country)
			end
		end
end
