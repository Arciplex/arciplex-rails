class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_sessioned_company
  
  def stored_location_for(resource)
    nil
  end
  
  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_path
    else
      service_requests_path
    end
  end

  def current_sessioned_company
    if current_user.admin?
      @current_sessioned_company = Company.find(session[:admin_company_id])
    end
  end
end
