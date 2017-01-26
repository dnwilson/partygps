module AddressModel
  extend ActiveSupport::Concern
  included do
    has_many :addresses, as: :addressable, dependent: :destroy
  end

  delegate :street_address, :street_address2, :city, :state, :zipcode, :country, :longitude, :latitude, to: :address

  def address
    addresses.first
  end
end
