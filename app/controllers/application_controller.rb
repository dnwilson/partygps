class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :disable_nav, :current_page
  before_action :block_outside_access
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # before_filter :authenticate_user!, :unless => :devise_controller?

  # This is our new function that comes before Devise's one
  # before_filter :authenticate_user_from_token!
  # This is Devise's authentication
  # before_filter :authenticate_user!

  # For CanCan authorization failure 
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end

  def block_outside_access
    binding.pry
    unless current_page.eql?(root_url) 
      unless location.country.eql?("Jamaica")
        flash[:warning] = "Unfortunately, our service is not yet available in your area"
        redirect_to root_path
      end
    end
  end

  private

    def disable_nav
      @disable_nav = true
    end

    def current_page
      @current_page = request.url
    end  
  
    def location
      if params[:location].blank?
        if Rails.env.test? || Rails.env.development?
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
      devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username, 
                  :email, :first_name, :last_name, :dob)}
      devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:username, 
                  :email, :first_name, :last_name, :dob, :sex, :address, 
                  :address2, :city, :state, :zipcode, :sex, :country )}
      devise_parameter_sanitizer.for(:edit_password) {|u| u.permit(:password, :password_confirmation, :current_password)}
    end
end
