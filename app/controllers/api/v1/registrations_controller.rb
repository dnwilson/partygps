class Api::V1::RegistrationsController < Devise::RegistrationsController
	skip_before_action :verify_authenticity_token,
					   :if => Proc.new{ |c| c.request.format == "application/json" }

	before_action :check_authentication, only: :update
	respond_to :json

	def create
		build_resource(sign_up_params)
		if resource.save
			sign_in resource
			render json: resource, meta: {success: true, status: 200, info: "Registation Completed!"}
			# render status: 200,
			# 	   json: { success: true,
			# 	   		   info: "Registered",
			# 	   		   data: { user: resource,
			# 	   		   	       auth_token: current_user.auth_token} }
		else
			render json: {error: resource.errors.full_messages.to_sentence, meta: {success: false, status: 422, info: "Registation Failed!"}}
			# render status: :unprocessable_entity,
			# 	   json: { success: false,
			# 	   		   info: resource.errors,
			# 	   		   data: {} }
		end
	end

	def update
		if current_user.update_attributes(sign_up_params)
			render json: resource, meta: {success: true, status: 200, info: "User Update Successful!"}
		else
		  render json: resource, meta: {success: false, status: 422, info: "User Update Failed!"}
		else
	end

	private

	def login_changed
	  @user.email != sign_up_params[:email] || @user.phone != sign_up_params[:phone]
	end

	def successfully_updated
		if email_changed
    	@user.update_with_password(sign_up_params)
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(sign_up_params)
    end
	end

	def sign_up_params
		params.require(:registration).permit(:email, :phone, :password, :first_name, :last_name, :role,
			:dob, :sex, :photo)
	end

end
