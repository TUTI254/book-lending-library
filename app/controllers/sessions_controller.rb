class SessionsController < ApplicationController
  skip_before_action :authenticate, only: %i[new create]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    if (user = User.authenticate_by(params.permit(:email_address, :password)))
      session[:user_id] = user.id
      redirect_to after_authentication_path, notice: "Signed in successfully."
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path, notice: "Signed out successfully."
  end

  private

  def after_authentication_path
    books_path
  end
end
