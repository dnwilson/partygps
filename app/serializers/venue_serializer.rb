class VenueSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :photo, :thumbnail, :street_address, :apt_suite, :city,
             :state, :zipcode, :country, :latitude, :longitude
  # attributes :id, :name, :description, :street_address, :apt_suite, :city, :state, :zipcode, :country
  #
  # def street_address
  #   address.street_address
  # end
  #
  def apt_suite
    object.street_address2
  end

  def photo
    object.photo.url
  end

  def thumbnail
    object.photo.thumb.url
  end
  #
  # def city
  #   address.city
  # end
  #
  # def state
  #   address.state
  # end
  #
  # def zipcode
  #   address.zipcode
  # end
  #
  # def country
  #   address.country
  # end
end
