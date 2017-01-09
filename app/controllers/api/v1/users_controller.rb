class Api::V1::UsersController < ApplicationController
  skip_before_action :check_authentication, only: [:check_user]

  def check_user
    @user = User.find_by_login(params[:login])
    if @user
      render json: @user, status: :ok
    else
      render json: { errors:
                      [
                        { status: 401, title: "Resource Not Found", detail: "User #{params[:login]}
                        not found." }
                      ]
                    }, status: 200
    end

  end

end
