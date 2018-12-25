class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do
    redirect_to root_path, danger: 'User not found!'
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    required_auth params[:id]

    @user = User.find(params[:id])
  end

  def edit_password
    required_auth params[:id]

    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      helpers.reset_user_id
      helpers.save_cookies @user.id
      redirect_to root_path, success: 'Your profile has been created'
    else
      render 'new'
    end
  end

  def update
    required_auth params[:id]; return if performed?

    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user), success: 'Your profile was updated'
    else
      render 'edit'
    end
  end

  def update_password
    required_auth params[:id]; return if performed?

    @user = User.find(params[:id])

    @user.class_eval do
      attr_accessor :old_password
    end

    if @user.authenticate(params[:user][:old_password])
      if @user.update(user_params)
        redirect_to user_path(@user), success: 'Your password was updated'
      else
        render 'edit_password'
      end
    else
      @user.assign_attributes(user_params)
      @user.valid?
      @user.errors.messages[:old_password] << 'Wrong old password!'

      render 'edit_password'
    end
  end

  def destroy
    required_auth params[:id]; return if performed?

    user = User.find(params[:id])
    user.destroy
    helpers.reset_user_id
    reset_session

    redirect_to root_path, info: 'Your profile was deleted'
  end

  private

  def user_params
    params.require(:user)
          .permit(:email, :password, :old_password, :password_confirmation, :first_name, :last_name)
  end

  def required_auth(id)
    redirect_to(new_session_path, info: 'Authentication is required') and return if
      User.find_by(id: id) && (!@user_id || @user_id != id.to_i)
  end
end
