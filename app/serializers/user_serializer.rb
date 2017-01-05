class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :first_name, :last_name, :phone, :dob,
             :provider, :uid, :role, :sex, :photo

  # has_many :user_addresses
end
