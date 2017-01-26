class ApplicationController < ActionController::Base
  include AuthenticatingController

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format == "application/vnd.api+json" }
  before_action :disable_nav, :current_page
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :set_location
  # around_action :set_time_zone


  # before_action :access_filter

  # before_filter :authenticate_user!, :unless => :devise_controller?

  # This is our new function that comes before Devise's one
  # before_filter :authenticate_user_from_token!
  # This is Devise's authentication
  # before_filter :authenticate_user!

  # before_action :check_authentication

  # For CanCan authorization failure
  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_to main_app.root_path, :alert => exception.message
  # end

  def access_filter
    region_blocker unless root_path
  end

  def region_blocker
    unless @location.try(:country).eql?("Jamaica")
      flash[:warning] = "Unfortunately, our service is not yet available in your area"
      redirect_to root_path
    end
  end

  private
    def set_time_zone(&block)
      time_zone = current_user.try(:time_zone) || 'UTC'
      Time.use_zone(time_zone, &block)
    end

    def check_authentication
      authenticate || render_unauthorized
    end

    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        user = User.get_user(token, params.symbolize_keys)
        sign_in user
      end
    end

    def disable_nav
      @disable_nav = true
    end

    def current_page
      @current_page = request.url
    end

    def set_location
      if params[:location].blank?
        if Rails.env.test?
          # Rails.env.development? ||
          # kingston  = "72.252.211.198"
          # portmore  = "72.27.99.0"
          # negril    = "208.131.163.126"
          # la        = "50.78.167.161"
          # nyc       = "24.90.208.237"
          kgn = "Kingston, Jamaica"
          nyc = "New York, NY"
          @location ||= Geocoder.search(kgn).first
        else
          @location ||= request.location
        end
      else
        params[:location].each {|l| l = l.to_i } if params[:location].is_a? Array
        @location ||= Geocoder.search(params[:location]).first
        @location
      end
    end


  # def authenticate_user_from_token!
  #   user_email = params[:user_email].presence
  #   user       = user_email && User.find_by_email(user_email)

  #   # Notice how we use Devise.secure_compare to compare the token
  #   # in the database with the token given in the params, mitigating
  #   # timing attacks.
  #   if user && Devise.secure_compare(user.authentication_token, params[:user_token])
  #     sign_in user, store: false
  #   end
  # end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :photo, :email, :first_name,
        :last_name, :dob, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :first_name,
        :last_name, :dob, :sex, :address, :address2, :city, :state, :zipcode, :sex, :country, :photo] )
      devise_parameter_sanitizer.permit(:edit_password, keys: [:password, :password_confirmation, :current_password])
    end
end
