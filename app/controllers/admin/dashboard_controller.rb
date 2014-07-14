class Admin::DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
    @companies = current_user.companies.uniq
  end
end
