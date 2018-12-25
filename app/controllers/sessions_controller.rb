class SessionsController < ApplicationController
  before_action do
    helpers.reset_user_id
  end

  def new; end

  def create
    user = User.find_by(email: params[:session][:email])

    if user&.authenticate(params[:session][:password])
      reset_session
      helpers.save_cookies user.id
      redirect_to root_path, success: "Welcome back #{user.full_name}!"
    else
      flash.now[:danger] = 'Wrong email or password!'
      render 'new'
    end
  end

  def destroy
    reset_session

    redirect_to root_path
  end
end
