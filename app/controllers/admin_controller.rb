class AdminController < ApplicationController

  before_action :redirect_to_login, unless: :admin?

  def settings
    @active_nav_tab = :admin
    @games = Game.all.order(:match_time)
  end

  def horses
    @active_nav_tab == :admin
  	@settings = Setting.all
  end

  def reports
    @active_nav_tab == :admin
    @reports = Report.all
    @report = Report.new
  end

  def create
  	Setting.create(name: params[:name], value: params[:value])
  	flash[:success] = "Submitted Successfully"
  	redirect_to '/admin/horses'
  end

  def delete_report
    Report.find(params[:id]).delete
    flash[:success] = "Deleted Successfully"
    redirect_to '/admin/reports'
  end

  def delete
    Setting.find(params[:id]).delete
    User.calculate_points
    flash[:success] = "Deleted Successfully"
    redirect_to '/admin/horses'
  end
end
