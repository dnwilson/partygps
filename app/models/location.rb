class Location < ActiveRecord::Base

	include PgSearch
	
	# Setup searchable fields
	multisearchable against: [:name, :street_address, :city_town, :state_parish]

	has_many :events

	mount_uploader :photo, ImageUploader

	geocoded_by :get_coordinates
	before_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
	reverse_geocoded_by :latitude, :longitude do |obj,results|
	  if geo = results.first
	  	obj.street_address	= geo.street_address
	    obj.city_town    		= geo.neighborhood
	    obj.state_parish 		= geo.city
	    obj.country 		 		= geo.country
	  end
	end
	after_validation :reverse_geocode
	# validates :street_address, presence: true
	# validates :city_town, length: { minimum: 2, maximum: 50 }
	# validates :state_parish, presence: true, length: { minimum: 2, maximum: 50 }
	# validates :country, presence: true

	validates :latitude, presence: {message: "Not a valid location on Google Maps. Please check name, address and parish on fields."}
	validates :longitude, presence: {message: "Not a valid location on Google Maps. Please check name, address and parish on fields."}

	def address
		[self.street_address, self.city_town, self.state_parish, self.country].compact.join(', ')
	end

	def get_coordinates
		[self.name, self.street_address, self.city_town, self.state_parish, self.country].compact.join(', ')
	end

	def address_changed?
	  attrs = %w(name street_address city_town state_parish country)
	  attrs.any?{|a| send "#{a}_changed?"}
  end

	def upcoming_events
		self.events.where("date IS NULL OR date >= ?", Date.today)
	end
end
