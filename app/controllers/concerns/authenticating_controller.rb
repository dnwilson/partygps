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
      render  json: current_user, meta: {success: true, status: 200, info: "Registation Completed!", is_logged_in: current_user.present?}
    end

    def render_logout
      render  json: { data:{message: "Logged out. See you soon!"},
                      meta: {success: true, status: 200, info: "Successful log out", is_logged_in: current_user.present?}}
    end

    def render_unauthorized
      self.headers['HTTP_CONTENT_TYPE'] = 'Token realm="Application"'
      self.headers['Content-Type'] = 'application/json'
      render json: {error: {message: "Unauthorized access. You must be logged in to perform this action."},
                    meta: {success: false, status: 401, info: "Unauthorized access", is_logged_in: current_user.present?}}, status: 401
    end

    def render_login_failure
      render json: {error:{message: "Invalid email or password. Please try again."},
                    meta: {success: false, status: 401, info: "Failed log in"}}, status: 401
    end
  end
end
