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

  resources :orders, only: [] do
    resources :notes
  end

  resources :companies do
    resources :service_requests do
      member do
        patch 'received'
        patch 'complete'
        get 'approve'
      end
    end

    match 'service_requests/:email_hash_id/print', to: 'service_requests#print', via: :get, as: 'print_service_request'

    resources :orders do
      member do
        patch 'received'
        patch 'complete'
      end
    end
  end

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    resources :users
  end

  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end

  resources :pages, only: [:show]

  mount ServiceRequests::API => '/api'
end
