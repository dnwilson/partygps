class AddressSerializer < ActiveModel::Serializer
  attributes :id, :street_address, :street_address2, :city, :state, :zipcode, :country
end
