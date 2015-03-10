class Dashboard::BaseController < ApplicationController
  # before_filter :verify_admin 

	helper :dashboard
	layout 'dashboard'

  def show
  end

  private
    def verify_admin
      authenticate_user!
      unless current_user.is_admin?
        redirect_to(root_path)
        flash[:warning] = "You do not have permission to carry out this function"
      end
    end
end