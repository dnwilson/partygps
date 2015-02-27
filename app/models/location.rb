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

	# scope :upcoming_events, -> { happening_now || where('events.listed_day IN (?)', [DateTime.now.strftime("%A"), DateTime.tomorrow.strftime("%A"), 2.days.from_now.strftime("%A")] ) }

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

  def current_events
  	self.events.where('events.start_dt >= ? AND events.start_dt <= ? OR events.category_id != ? AND events.listed_day = ?', 
                                Date.today.to_time, DateTime.tomorrow, Category.where(name: REG).first.id, DateTime.now.strftime("%A"))
  end

	def todays_events
		current_events || self.events.where('events.listed_day IN (?)', [DateTime.now.strftime("%A"), DateTime.tomorrow.strftime("%A"), 2.days.from_now.strftime("%A")])
	end

	def upcoming_events
		events.includes(:category).where('listed_day >= ?', Date.today.to_time).order(:start_dt, :listed_type, :listed_day)
	end

	def recurring_events
		events.includes(:category).where('category_id != ?', Category.where(name: REG).first.id)
	end
end
