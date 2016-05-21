class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def restrict_access
    if !current_player
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end
  def current_player
    @current_player ||= Player.find(session[:player_id]) if session[:player_id]
  end

  def dota_api
    Dota.api
  end

  helper_method :current_player
end
