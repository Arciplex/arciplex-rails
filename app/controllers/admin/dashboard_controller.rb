class Admin::DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @companies = Company.not_arciplex
  end
end