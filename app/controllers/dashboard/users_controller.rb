class Dashboard::UsersController < Dashboard::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :verify_admin
  load_and_authorize_resource

  def index
    @users = User.where.not(id: current_user.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Successfully created User." 
      redirect_to dashboard_users_path
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated User."
      redirect_to dashboard_users_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = "Successfully deleted User."
      redirect_to dashboard_users_path
    end
  end


  private
    
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, 
                  :email, :first_name, :last_name, :dob, :sex, :address, 
                  :address2, :city, :state, :zipcode, :country, :photo, :password, 
                  :password_confirmation)
    end
end