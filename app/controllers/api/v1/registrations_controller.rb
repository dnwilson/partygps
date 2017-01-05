class Api::V1::RegistrationsController < Devise::RegistrationsController
	skip_before_action :verify_authenticity_token,
					   :if => Proc.new{ |c| c.request.format == "application/json" }


	respond_to :json

	def create
		build_resource(sign_up_params)
		# binding.pry
		if resource.save
			sign_in resource
			render json: resource, meta: {success: true, status: 200, info: "Registation Completed!"}
			# render status: 200,
			# 	   json: { success: true,
			# 	   		   info: "Registered",
			# 	   		   data: { user: resource,
			# 	   		   	       auth_token: current_user.auth_token} }
		else
			render json: resource, meta: {success: false, status: 422, info: "Registation Failed!"}
			# render status: :unprocessable_entity,
			# 	   json: { success: false,
			# 	   		   info: resource.errors,
			# 	   		   data: {} }
		end
	end

	private

	def sign_up_params
		params.require(:registration).permit(:email, :phone, :password, :first_name, :last_name, :role)
	end

end
