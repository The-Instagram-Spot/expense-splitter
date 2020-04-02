Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
  root 'groups#index'
  
  resources :groups do
    resources :transactions
    resources :user
  end

  resources :transactions do
    patch :update_users
  end
  
  resources :user do
    resources :transactions
  end
  
  delete '/user/:user_id/transactions/:id/destroy_from_transaction', to: 'user#destroy_from_transaction', as: 'destroy_from_transaction'
  patch '/group/:group_id/transactions/:id/update_users', to: 'transactions#update_users', as: 'update_users'
  get '/user/:user_id/settle_up', to: 'user#settle_up', as: 'settle_up'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
