Arciplex::Application.routes.draw do
  devise_for :users, skip: [:registration]
  
  devise_scope :user do
    get "/logout" => "devise/sessions#destroy"
    root to: "devise/sessions#new"
  end
  
  resources :customers
  resources :service_requests, only: [] do
    resources :notes
  end
  resources :companies do
    resources :service_requests
  end

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
  end
  
  match "/service_requests/:id/received" => "service_requests#received", via: :patch, as: "service_request_received"
end
