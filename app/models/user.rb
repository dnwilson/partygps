class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :omniauthable,
	     :recoverable, :rememberable, :trackable, :validatable

	before_validation :set_role, on: :create
	# before_create :set_role
	before_validation :set_username, on: :create
	before_create :ensure_authentication_token

	has_many :authorizations

	mount_uploader :photo, ImageUploader

	validates :first_name, presence: true, length: {minimum: 2, maximum: 50 }
	validates :last_name, presence: true, length: {minimum: 2, maximum: 50 }
	validates :address, length: {maximum: 100 }
	validates :address2, length: {maximum: 50 } 
	validates :state, length: {maximum: 50 }
	validates :city, length: {maximum: 50 } 
	validates :zipcode, length: {maximum: 20 }
	validates :role, presence: true
	
	ROLES = %w[user admin]

	def role?(base_role)
		role.present? && ROLES.index(base_role.to_s) <= ROLES.index(role)
	end

	def fullname
		self.first_name + " " + self.last_name
	end

	def is_admin?
		role.eql?("admin")
	end

	def is_user?
		role.eql?("user")
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
				auth[:provider].eql?("twitter") ?  user.save(:validate => false) :  user.save
			end
			# authorization.username = auth["info"]["nickname"]
			authorization.user_id = user.id
			authorization.save
		end
		authorization.user
	end

	def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
	  model = Model.where(:provider => auth.provider, :uid => auth.uid).first
	  return model if model
	  model = Model.create(name:auth.extra.raw_info.name,
	                         provider:auth.provider,
	                         uid:auth.uid,
	                         email:auth.info.email,
	                         password:Devise.friendly_token[0,20]
	                         )
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
