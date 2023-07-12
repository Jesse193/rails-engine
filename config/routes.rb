Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: "merchants/items"
      end
      resources :items, only: [:index, :show, :create, :destroy, :update] do
        resources :merchant, only: [:index], controller: "items/merchants"
      end
    end
  end
end
