class ApplicationController < ActionController::Base
  protect_from_forgery :with => :reset_session

  def current_user
    User.find_by_session_token(session[:session_token])
  end
end
