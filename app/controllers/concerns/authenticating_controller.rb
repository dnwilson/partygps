module AuthenticatingController
  extend ActiveSupport::Concern

  included do
    # def api_token
    #   @api_token ||= @api_key.try(:access_token)
    # end
    #
    # def token_user
    #   @token_user ||= ApiKey.try(:owner, api_token)
    # end

    def render_login_success
      render  json: current_user, status: 200, meta: {info: "Registation Completed!"}
    end

    def render_logout
      render  json: { meta: {title: "Log Out", details: "Logged out. See you soon!"}}
    end

    def render_unauthorized
      self.headers['HTTP_CONTENT_TYPE'] = 'Token realm="Application"'
      self.headers['Content-Type'] = 'application/json'
      render json: {error: {status: 401, title: "Unauthorized Access", message: "Unauthorized
        access. You must be logged in to perform this action."}}, status: 401
    end

    def render_login_failure
      render json: {error:{title: "Login Failure", detail: "Invalid email or password. Please try
        again."}, status: 200 }
    end
  end
end
