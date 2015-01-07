class Location < ActiveRecord::Base

	has_many :events

	geocoded_by :address, if: ->(obj){ obj.address.present? and obj.address_changed? }
	after_validation :geocode          # auto-fetch coordinates

	validates :street_address, presence: true
	validates :city_town, length: { minimum: 2, maximum: 50 }
	# validates :state_parish, presence: true, length: { minimum: 2, maximum: 50 }
	validates :country, presence: true

	# validates :latitute, presence: true
	# validates :longitude, presence: true

	def address
		[self.street_address, self.street_address2, self.city_town, self.state_parish, self.country].compact.join(', ')
	end
end
