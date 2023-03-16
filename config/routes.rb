Rails.application.routes.draw do
  root 'home#page'
  resources :articles
  resources :users

  get 'signup', to: 'users#new'
end
