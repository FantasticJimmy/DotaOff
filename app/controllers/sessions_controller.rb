require 'pry'
class SessionsController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: :create

  def create
    #render text: request.env['omniauth.auth'].to_yaml and return
    begin
      @player = Player.from_omniauth request.env['omniauth.auth']
    rescue
      flash[:error] = "Can't authorize you..."
    else
      # @player.load_matches!(3)
      session[:player_id] = @player.id
    end
    redirect_to player_dashboard_path(@player), notice: "Welcome, #{@player.nick_name}"
  end

  # def back_to_admin
  #   session[:user_id] = session[:me]
  #   session[:me] = nil
  #   redirect_to admin_users_path
  # end

  def destroy
    session[:player_id] = nil
    redirect_to root_path, notice: "Adios!"
  end
  
end
