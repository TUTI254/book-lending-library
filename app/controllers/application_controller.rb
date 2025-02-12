class ApplicationController < ActionController::Base
  before_action :authenticate

  helper_method :authenticated?, :current_user

  private

  def authenticate
    redirect_to new_session_path, alert: "You must log in first" unless authenticated?
  end

  def authenticated?
    session[:user_id].present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
