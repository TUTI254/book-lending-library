class ApplicationController < ActionController::Base
  before_action :authenticate
  helper_method :current_user # Make current_user available in views

  private

  def authenticate
    redirect_to new_session_path unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
