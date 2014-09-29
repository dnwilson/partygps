class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable

	before_save :set_username

	# has_many :authorizations

	validates :first_name, presence: true, length: {minimum: 2, maximum: 50 }
	validates :last_name, presence: true, length: {minimum: 2, maximum: 50 }
	validates :address, length: {maximum: 100 }
	validates :address2, length: {maximum: 50 } 
	validates :state, length: {maximum: 50 }
	validates :city, length: {maximum: 50 } 
	validates :zipcode, length: {maximum: 20 }
	validates :role,  presence: true

	ROLES = %w[user promoter admin]

	def role?(base_role)
		ROLES.index(base_role.to_s) <= ROLES.index(role)
	end

	private
  
	def set_username
		self.username = "user_#{User.count + 1}"
	end

end
