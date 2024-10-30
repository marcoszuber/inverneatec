Rails.application.routes.draw do
  get 'user_manager/index'
  get 'user_manager/update_user_type'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "pages#home"
  resources :muestreos do
    collection do
      post :import
    end
  end
  resources :archivos

  resources :users do
    resources :contratos
  end

  resources :user_manager, only: [:index, :show], controller: 'user_manager' do
    member do
      patch :update_user_type
    end
  end

end
