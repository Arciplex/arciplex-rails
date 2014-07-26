class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_company

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def stored_location_for(resource)
    nil
  end

  def after_sign_in_path_for(resource)
    return admin_path if resource.admin?

    if resource.companies.many?
      admin_path
    else
      company_service_requests_path(company_id: resource.companies.first.id)
    end

  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def current_company
    @current_company ||= Company.find(params[:company_id]) if params[:company_id].present?
  end
end
