Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: "home#index"
  resources :listings, only: [:index]
  get "/listings/:mls_number", to: "listings#show", as: :listing

  namespace :api, defaults: { format: :json } do
  namespace :v1 do
    resources :listings, only: [:index]
  end
end
end
