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
      company_service_requests_path(company_id: current_user.company_id)
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end
