class ReportsController < ApplicationController
  def index
    @active_nav_tab = :standings
  	@active_tab = 'reports'
  	@reports = Report.where(user: current_account.users)
  end

  def show
    @active_nav_tab = :standings
  	@report = Report.find(params[:id])
  end

  def create
  	@report = Report.new(report_params)
    if not @report.save
      flash[:error] = @report.errors.full_messages
    end
    redirect_to '/admin/reports'
  end

  def report_params
    params.require(:report).permit(:content, :user_id, :report_date)
  end
end
