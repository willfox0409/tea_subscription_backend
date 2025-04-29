Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :subscriptions, only: [:index, :show, :update]
      resources :customers, only: [:index]
      resources :teas, only: [:index]
    end
  end
end