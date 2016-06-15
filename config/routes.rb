Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }, skip: [:sessions]
  devise_for :users, :skip => [:sessions]
  as :user do
    get 'signin' => 'devise/sessions#new', as: :new_user_session
    post 'signin' => 'devise/sessions#create', as: :user_session
    delete 'signout' => 'devise/sessions#destroy', as: :destroy_user_session
  end
  get "/buyeragreement", to: "signing#new", as: :signing
  post "/buyeragreement", to: "signing#create", as: :sign
  root to: "home#index"
  resources :listings, only: [:index]
  get "/listings/:mls_number", to: "listings#show", as: :listing

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :listings, only: [:index]
    end
  end

  namespace :admin do
    resources :imports, only: [:new, :create] 
    get "/imports/latest", to: "imports#show", as: :latest_import
  end
end
