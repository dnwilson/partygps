class Location < ActiveRecord::Base

	include PgSearch
	# Setup searchable fields
	multisearchable against: [:name, :street_address, :city_town, :state_parish]

	has_many :events

	mount_uploader :photo, ImageUploader

	geocoded_by :address, if: ->(obj){ obj.address.present? and obj.address_changed? }
	after_validation :geocode          # auto-fetch coordinates
	
	# validates :street_address, presence: true
	# validates :city_town, length: { minimum: 2, maximum: 50 }
	validates :state_parish, presence: true, length: { minimum: 2, maximum: 50 }
	validates :country, presence: true

	# validates :latitude, presence: {message: "Not a valid location on Google Maps. Please check name, address and parish on fields."}
	# validates :longitude, presence: {message: "Not a valid location on Google Maps. Please check name, address and parish on fields."}

	# scope :upcoming_events, 


	def address
		[self.street_address, self.city_town, self.state_parish, self.country].compact.join(', ')
	end

	def upcoming_events
		self.events.where("date IS NULL OR date >= ?", Date.today)
	end
end
