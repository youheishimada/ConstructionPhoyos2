Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :projects, only: [:index, :show, :new, :create] do
    resources :photos, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      member do
        get :download_original
        get :download_with_blackboard
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end