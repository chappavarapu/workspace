Rails.application.routes.draw do
  resources :todo_items
  resources :todo_lists
  resources :profiles
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
