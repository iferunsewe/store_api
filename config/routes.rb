Rails.application.routes.draw do
  resources :items, except: [:show, :create, :destroy]
  resources :quotes, only: [:create, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
