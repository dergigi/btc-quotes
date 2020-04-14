Rails.application.routes.draw do
  root 'quotes#random'
  resources :authors, only: [:index]
  resources :quotes, only: [:index, :show] do
    collection do
      get 'random'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
