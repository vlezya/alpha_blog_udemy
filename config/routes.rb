Rails.application.routes.draw do
  root 'home#page'
  resources :articles

  get 'signup', to: 'users#new'
  post 'users', to: 'users#create'
end
