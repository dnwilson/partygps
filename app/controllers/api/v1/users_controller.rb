class Api::V1::UsersController < ApplicationController
  # skip_before_action :check_authentication, only: [:check_user]

  def check_user
    @user = User.find_by_login(params[:login])
    render json: @user, status: :ok
  end

end
