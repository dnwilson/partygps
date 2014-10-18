class UsersController < ApplicationController
  # before_action :set_user, only: [:show]

  def show
  	@user = User.find(params[:id])
  end

  private
  	def set_user
  		binding.pry
  		@user = User.find(params[:id])
  	end
  	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end

end
