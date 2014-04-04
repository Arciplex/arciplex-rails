class Admin::DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @companies = Company.not_arciplex
  end

  def set_company
    @company = Company.find(params[:company_id])

    if @company
      session[:admin_company_id] = @company.id
      redirect_to service_requests_path, notice: "Viewing Service Requests for #{@company.name}"
    end
  end
end