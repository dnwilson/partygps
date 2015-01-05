class Place < ActiveRecord::Base

	has_many :events

	validates :street_address, presence: true
	validates :city_town, length: { minimum: 2, maximum: 50 }
	validates :state_parish, presence: true, length: { minimum: 2, maximum: 50 }
	validates :country, presence: true

	# validates :latitute, presence: true
	# validates :longitude, presence: true
end
