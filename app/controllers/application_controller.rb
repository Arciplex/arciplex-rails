class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def stored_location_for(resource)
    nil
  end
  
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || service_requests_path
  end
end
