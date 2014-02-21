Arciplex::Application.routes.draw do
  devise_for :users, skip: [:registration]
  
  devise_scope :user do
    get "/logout" => "devise/sessions#destroy"
    root to: "devise/sessions#new"
  end
  
  resources :customers
  resources :service_requests do
    resources :notes
  end
  
  match "/service_requests/:id/received" => "service_requests#received", via: :patch, as: "service_request_received"
end
