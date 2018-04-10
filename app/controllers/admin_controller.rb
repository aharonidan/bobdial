class AdminController < ApplicationController

  before_action :redirect_to_login, unless: :admin?
  
  def settings
    @games = Game.all
  end
end
