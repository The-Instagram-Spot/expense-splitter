Rails.application.routes.draw do

  get 'users/index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, :only =>[:show]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
  root 'groups#index'
  
  resources :people
  resources :groups do
    resources :transactions
  end
  resources :member_of_groups
  
  match '/users', to: 'users#index', via: 'get'
  match '/users/:id', to: 'users#show', via: 'get'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
