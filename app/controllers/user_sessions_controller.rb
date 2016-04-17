class UserSessionsController < ApplicationController

  def new
  end

  def create
    if login(params[:email], params[:password], params[:remember_me])
      flash[:success] = "Logged in"
      redirect_back_or_to root_path
    else
      flash.now[:danger] = 'Login Failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    flash[:success] = 'Logged out'
    redirect_back_or_to root_path
  end
end
