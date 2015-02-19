class Admin::BaseController < ApplicationController
  before_filter :verify_admin 

	helper :admin
	layout 'admin'

  private
    def verify_admin
      authenticate_user!
      unless current_user.is_admin?
        redirect_to(root_path)
        flash[:warning] = "You do not have permission to carry out this function"
      end
    end
end