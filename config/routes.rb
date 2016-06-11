Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  as :user do
    get "/login" => "devise/sessions#new"
    get "sign_up" => "devise/registrations#new"
  end
  root to: "home#index"
  resources :listings, only: [:index]

  namespace :api, defaults: { format: :json } do
  namespace :v1 do
    resources :listings, only: [:index]
  end
end
end
