class HomeController < ApplicationController
  # before_action :authenticate_player!
  def index
    @player=Player.new
    @minimum_password_length=4
  end
end