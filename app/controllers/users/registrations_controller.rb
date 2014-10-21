class Users::RegistrationsController < Devise::RegistrationsController
	prepend_before_filter :authenticate_scope!, only: [:edit, :update, :destroy, :password]
	before_filter :disable_nav, only: [:new]

    def update_password
    	@disable_chan = true
    	@user = current_user
    	Rails.logger.info "entered update_password"
    	if @user.update_with_password(devise_parameter_sanitizer.sanitize(:edit_password))    		
    		#Sign in the user by passing validation in case his password has changed
    		sign_in @user, :bypass => true
    		flash[:success] = "Password updated"
    		Rails.logger.info(devise_parameter_sanitizer.sanitize(:edit_password).inspect)
    		redirect_to settings_password_path
    	else
    		Rails.logger.info(@user.errors.inspect)
    		flash[:warning] = "Password not updated"
    		render 'password'
    	end
    end

    def password
    	@disable_chan = true
    	@user = current_user
    end

    def location
    	@disable_chan = true
    	@user = current_user
    end

    def create
    	@disable_chan = true
	    build_resource(sign_up_params)

	    if resource.save
	      if resource.active_for_authentication?
	        # set_flash_message :notice, :signed_up if is_navigational_format?
	        flash[:success] = "Welcome to the community. Please remember to update your profile information."
	        sign_up(resource_name, resource)
	        respond_with resource, :location => after_sign_up_path_for(resource)
	      else
	        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
	        expire_session_data_after_sign_in!
	        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
	      end
	    else
	      clean_up_passwords resource
	      respond_with resource
	    end
	end
	def update
		@disable_chan = true
		@user = User.find(current_user.id)
		email_changed = @user.email != params[:user][:email]
		successfully_updated = if email_changed
		@user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
		else
		  # remove the virtual current_password attribute update_without_password
		  # doesn't know how to ignore it
		  params[:user].delete(:current_password)
		  @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
		end

		if successfully_updated
		  # set_flash_message :notice, :updated
		  # Sign in the user bypassing validation in case his password changed
		  # sign_in @user, :bypass => true
		  Rails.logger.info(@user.errors.inspect)
		  flash[:success] = "Profile updated"
		  redirect_to settings_path
	      # UserMailer.profile_update(@user).deliver
		else
		  render "edit"
		end
	end

	private
	# check if we need password to update user data
	# ie if password or email was changed
	# extend this as needed
		def needs_password?(user, params)
			user.email != params[:user][:email] ||
			params[:user][:password].present?
		end	
  
	protected
		def after_update_path_for(resource)
			session[:next] || super
		end

		def after_sign_up_path_for(resource)
			settings_path(resource)
			# user_path(resource)
		end

end