class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # has_many :authorizations

  ROLES = %w[user promoter admin]


  def role?(base_role)
  	ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

end
