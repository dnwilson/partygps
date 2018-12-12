class AddressSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :street_address, :street_address2, :city, :state, :zipcode, :country
end