class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :omniauthable,
	     :recoverable, :rememberable, :trackable, :validatable

	before_validation :set_role, on: :create
	before_validation :set_username, on: :create
	before_create :ensure_auth_token

	has_many :authorizations
	has_many :user_addresses

	attr_accessor :login

	mount_uploader :photo, ImageUploader

	validates :first_name, presence: true, length: {minimum: 2, maximum: 50 }
	validates :last_name, presence: true, length: {minimum: 2, maximum: 50 }
	validates :address, length: {maximum: 100 }
	validates :address2, length: {maximum: 50 }
	validates :state, length: {maximum: 50 }
	validates :city, length: {maximum: 50 }
	validates :zipcode, length: {maximum: 20 }
	validates :role, presence: true
	validate :validates_presence_of_login
	validate :validate_username

	ROLES = %w[guest user admin super_admin]

	def role?(base_role)
		ROLES.index(base_role.to_s) <= ROLES.index(role)
	end

	def fullname
		self.first_name + " " + self.last_name
	end

	def is_admin?
		["super_admin", "admin"].include?(role) rescue nil
	end

	def is_user?
		role.eql?("user") rescue nil
	end

	def ensure_auth_token
		if auth_token.blank?
			self.auth_token = generate_auth_token
		end
	end

	# To enable login with either :username or :email
	def self.find_for_database_authentication(warden_conditions)
		conditions = warden_conditions.dup
		if login = conditions.delete(:login)
			# where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value OR
			# 	lower(phone) = :value", { value: login.downcase }]).first
			where(conditions.to_hash).find_by_login(login)
		elsif conditions.has_key?(:username) || conditions.has_key?(:email) || conditions.has_key?(:phone)
			where(conditions.to_hash).first
		end
	end

	def self.find_by_login(login)
		where(["lower(email) = :value OR lower(phone) = :value OR lower(username) = :value",
			{ value: login.downcase }]).first
	end

	def self.get_user(token, params)
		if params[:provider]
			# process omniauth Login
			# return nil unless params[:provider] && token
			# user = get_auth_account(params[:uid], params[:provider])
			# unless user && user.token.eql?(token) && ApiKey.is_valid?(token)
			# 	if user
			# 		user.renew_token
			# 	else
			# 		user = send("create_#{params[:provider]}_user".to_sym, token, params)
			# 	end
			# end
			# user
		else
			where(auth_token: token, email: params[:email]).first
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

	# Needed to signup without email
	def email_required?
		false
	end

	def email_changed?
		false
	end

	def validates_presence_of_login
	  errors.add(:login, :invalid) unless username || email || phone
	end

	def validate_username
		if User.where(email: username).exists?
	    errors.add(:username, :invalid)
	  end
	end


	private

		def set_username
			return unless self.username.nil?
			self.username = "user_#{User.count + 1}"
		end

		def generate_auth_token
			loop do
				token = Devise.friendly_token
				break token unless User.where(auth_token: token).first
			end
		end

		def set_role
			unless role.present?
				self.role = "user"
			end
		end

end
