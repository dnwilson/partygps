class Location < ActiveRecord::Base

	has_many :events

	geocoded_by :address, if: ->(obj){ obj.address.present? and obj.address_changed? }
	after_validation :geocode          # auto-fetch coordinates
	
	# validates :street_address, presence: true
	# validates :city_town, length: { minimum: 2, maximum: 50 }
	# # validates :state_parish, presence: true, length: { minimum: 2, maximum: 50 }
	# validates :country, presence: true

	validates :latitude, presence: {message: "Not a valid location on Google Maps. Please check name, address and parish on fields."}
	validates :longitude, presence: {message: "Not a valid location on Google Maps. Please check name, address and parish on fields."}

	def address
		[self.street_address, self.city_town, self.state_parish, self.country].compact.join(', ')
	end
end
