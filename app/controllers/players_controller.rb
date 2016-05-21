class PlayersController < ApplicationController
  def new
    @player=Player.new
    @minimum_password_length=4
  end
end