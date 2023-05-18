Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      scope :auth do
        post "/sign_up", to: "sessions#sign_up"
        post "/log_in", to: "sessions#log_in"
        get "/me", to: "sessions#me"
      end
      resources :companies, except: [:show] do
        get "/current", to: "companies#show", on: :collection
      end
      resources :products, only: [:create, :index, :show, :update]
      resources :categories, only: [:index]
    end
  end
end
