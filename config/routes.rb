Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users do
    member do 
      get :likes
    end
  end

  
  resources :items, only: [:index, :show, :new, :create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
