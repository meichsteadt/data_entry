class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticated?
  helper_method :current_user

  def authenticate_user(user_id, password)
    begin
      user = User.find_by_login(user_id).authenticate(password)
      rescue NoMethodError
        flash[:notice] = "Login and password incorrect"
        redirect_to "/sessions/new"
    end
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    else
      false
    end
  end

  def authenticated?
    unless current_user
      redirect_to "/sessions/new"
    end
  end
end
