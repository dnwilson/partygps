class UserSerializer #< ActiveModel::Serializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :username, :first_name, :last_name, :phone, :dob,
             :provider, :uid, :role, :sex, :photo

  # has_many :user_addresses
end
