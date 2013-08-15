module SessionsHelper

  def current_user
    User.find_by_session_token(session[:token])
  end
end
