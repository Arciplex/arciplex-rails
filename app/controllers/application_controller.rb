class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    helper_method :current_company

    rescue_from CanCan::AccessDenied do |exception|
        redirect_to after_sign_in_path_for(current_user), alert: exception.message
    end

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def stored_location_for(resource)
        nil
    end

    def after_sign_in_path_for(resource)
        return admin_path if resource.companies.many?

        company_service_requests_path(company_id: resource.companies.first.id)
    end

    def current_ability
        @current_ability ||= Ability.new(current_user)
    end

    def current_company
        @current_company ||= Company.find(params[:company_id]) if params[:company_id].present?
    end
end
