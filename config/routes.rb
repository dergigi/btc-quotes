Rails.application.routes.draw do
  root 'quotes#random'
  resources :authors
  resources :quotes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
