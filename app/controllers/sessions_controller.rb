class SessionsController < ApplicationController
  skip_before_action :authenticated?, only: [:new, :create, :destroy]
  def new

  end

  def create
    authenticate_user(params[:login], params[:password])
    redirect_to products_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/sessions/new"
  end
private
  def sessions_params
    params.permit(:login, :password)
  end
end
