class Api::V1::SessionsController < Devise::SessionsController
	# skip_before_filter :verify_authenticity_token,
	# 				   :if => Proc.new{ |c| c.request.format == "application/json" }

	before_action :check_authentication, except: [:create]


	respond_to :json

	# def create
	# 	warden.authenticate!(scope: resource_name, recall: "#{controller_path}#failure")
	# 	render status: 200,
	# 		   json: { success: true,
	# 		   		   info: "Logged in",
	# 		   		   data: { auth_token: current_user.authentication_token }
	#
	# 		   }
	# end

	def create
		user = User.find_for_database_authentication(login: session_params[:login])
		return render_login_failure unless user

		if user.valid_password?(session_params[:password])
			sign_in("user", user)
			render_login_success
		else
			render_login_failure
		end
	end

	def destroy
		warden.authenticate!(scope: resource_name, recall: "#{controller_path}#failure")
		current_user.update_column(authentication_token: nil)
		render status: 200,
			   json: { success: true,
			   		   info: "Logged out",
			   		   data: { auth_token: current_user.authentication_token }

			   }
	end

	def failure
		render status: 401,
		       json: { success: false,
		               info: "Login Failed",
		               data: {}
		           }
	end

	private

	def session_params
		params.require(:session).permit(:login, :password)
	end

end
