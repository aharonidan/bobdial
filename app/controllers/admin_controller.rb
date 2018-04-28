class AdminController < ApplicationController

  before_action :redirect_to_login, unless: :admin?

  def settings
    @active_nav_tab = :admin
    @games = Game.all.order(:id)
  end

  def horses
    @active_nav_tab == :admin
  	@settings = Setting.all
  end

  def create
  	Setting.create(name: params[:name], value: params[:value])
  	flash[:success] = "Submitted Successfully"
  	redirect_to '/admin/horses'
  end

  def delete
    Setting.find(params[:id]).delete
    User.calculate_points
    flash[:success] = "Deleted Successfully"
    redirect_to '/admin/horses'
  end
end
