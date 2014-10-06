class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :omniauthable,
	     :recoverable, :rememberable, :trackable, :validatable

	before_save :set_username
	before_save :ensure_authentication_token
	before_save :set_role

	has_many :authorizations

	validates :first_name, presence: true, length: {minimum: 2, maximum: 50 }
	validates :last_name, presence: true, length: {minimum: 2, maximum: 50 }
	validates :address, length: {maximum: 100 }
	validates :address2, length: {maximum: 50 } 
	validates :state, length: {maximum: 50 }
	validates :city, length: {maximum: 50 } 
	validates :zipcode, length: {maximum: 20 }

	ROLES = %w[user promoter admin]

	def role?(base_role)
		ROLES.index(base_role.to_s) <= ROLES.index(role)
	end

	def ensure_authentication_token
		if authentication_token.blank?
			self.authentication_token = generate_authentication_token
		end
	end

	def self.new_with_session(params,session)
		if session["devise.user_attributes"]
			new(session["devise.user_attributes"],without_protection: true) do |user|
				user.attributes = params
				user.valid?
			end
		else
			super
		end
	end

	def self.from_omniauth(auth, current_user)
		authorization = Authorization.where(:provider => auth["provider"], :uid => auth["uid"].to_s, :token => auth["credentials"]["token"], :secret => auth["credentials"]["secret"]).first_or_initialize
		if authorization.user.blank?
			user = current_user.nil? ? User.where('email = ?', auth["info"]["email"]).first : current_user
			if user.blank?
				user = User.new
				user.password = Devise.friendly_token[0,10]
				user.first_name = auth["info"]["first_name"]
				user.last_name = auth["info"]["last_name"]
				user.email = auth["info"]["email"]
				auth[:provider] == "twitter" ?  user.save(:validate => false) :  user.save
			end
			# authorization.username = auth["info"]["nickname"]
			authorization.user_id = user.id
			authorization.save
		end
		authorization.user
	end

	# Admin configuration
	rails_admin do
		edit do
	      field :first_name
	      field :last_name
	      field :dob 
	      field :email
	      field :address
	      field :address2
	      field :city
	      field :state
	      field :zipcode
	      field :country
	      field :password
	      field :password_confirmation
    	end
	end

	private
  
		def set_username
			self.username = "user_#{User.count + 1}"
		end

		def generate_authentication_token
			loop do
				token = Devise.friendly_token
				break token unless User.where(authentication_token: token).first
			end
		end

		def set_role
			unless role.present?
				self.role = "user"
			end
		end

end
