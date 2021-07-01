class UsersController < ApplicationController
  before_action :set_user, only: [
    :show, :update, :destroy, :add_role, 
    :remove_role, :get_user_roles, 
    :get_user_courses, :assign_course, :remove_course
  ]
  def index
    @users = User.all
    render json: @users
  end


  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end


  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def update
    @user = User.find(params[:id])

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end


    if @user.update_attributes(user_params)
      sign_in(@user, :bypass => true) if @user == current_user
      redirect_to @user, :flash => { :success => 'User was successfully updated.' }
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      render json: { :success => 'User was successfully deleted.' }
    end
  end
  

  #This method adds a role to a user
  # POST http://localhost:3033/users/id/add_role
  def add_role
    @user = User.find(params[:id])
    if @user
      if @user.has_role? params[:role]
        render json: { :success => 'user already has this role' }
      else
        @user.add_role params[:role]
        render json: { :success => 'successfully add role' }
      end
    else
      render json: { errors: "user does not exist" }, status: :unprocessable_entity
    end
  end
 
  #This method removes a role to a user
  # POST http://localhost:3033/users/id/remove_role
  def remove_role
    if @user.has_role? params[:role]
      @user.remove_role params[:role]
      render json: { :success => 'role successfully removed' } 
    else   
      render json: { :success => 'The user does not have this role' }
    end
  end
  
  def get_all_roles
    #@roles= Role.all # return and array of objects
    @roles= Role.all.pluck(:name)
    render json: @roles
  end

   # This method returns all the available roles for a particular user
   # GET http://localhost:3033/users/id/get_user_roles
  def get_user_roles
    @roles = @user.roles.pluck(:name)
    render json: @roles
  end
  
  
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit!
  end
=begin   
  def new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
  end

  def show
  end
=end
end
