class ApplicationController < ActionController::Base
  before_action :set_session

  add_flash_types :warning, :success, :danger, :info

  private

  def set_session
    session[:user_id] = cookies.encrypted[:user_id] if cookies.key?(:user_id)
    @user_id = session[:user_id] if cookies.key?(:user_id)
  end
end
