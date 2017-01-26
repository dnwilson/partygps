class Venue < ActiveRecord::Base
	include PgSearch
	include AddressModel

	has_many :events

	mount_uploader :photo, ImageUploader

	default_scope { includes(:addresses) }

	# Setup searchable fields
	# multisearchable against: [:name, :street_address, :city, :state]

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
