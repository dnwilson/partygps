class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true

  delegate :town, to: :city
  delegate :parish, to: :state

  geocoded_by :full_street_address
  before_validation :geocode, if: ->(obj){ obj.full_street_address.present? and obj.address_changed? }
  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.street_address	= geo.street_address
      obj.city 		= geo.neighborhood
      obj.state		= geo.city
      obj.country = geo.country
    end
  end
  after_validation :reverse_geocode

  # validates :latitude, presence: {message: "Not a valid location on Google Maps. Please check name, address and parish on fields."}
  # validates :longitude, presence: {message: "Not a valid location on Google Maps. Please check name, address and parish on fields."}

  def address
	  addresses.first
	end

  def full_street_address
    user_address
    # return self.addressable.is_a?(Venue) ? venue_address : user_address
  end

  def user_address
    [self.street_address, self.state, self.country].compact.join(', ')
  end

  def venue_address
    address = [self.street_address, self.state, self.country]
    address.push(self.addressable.name) if self.addressable.name.present?
    address.compact.join(', ')
  end

  def address_changed?
    attrs = %w(street_address city state country)
    attrs.any?{|a| send "#{a}_changed?"}
  end
end
