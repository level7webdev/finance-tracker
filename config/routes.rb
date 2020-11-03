Rails.application.routes.draw do
  
  root 'welcome#index'
  
  devise_for :users
  
  get 'my_portfolio', to: 'users#my_portfolio'
  
  get 'search_stock', to: 'stocks#search'

  resources :stocks, only: [:update]

  resources :user_stocks, only: [:create, :destroy]
  
  get 'my_friends', to: 'users#my_friends'
  
  get 'search_friends', to: 'users#search'
  
  resources :friendships, only: [:create, :destroy]
  
  resources :users, only: [:show]

end