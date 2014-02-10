Arciplex::Application.routes.draw do
  devise_for :users, skip: [:registration]
  
  devise_scope :user do
    get "/logout" => "devise/sessions#destroy"
    root to: "devise/sessions#new"
  end
  
  resources :customers
  resources :service_requests, path: "service-requests"
end
