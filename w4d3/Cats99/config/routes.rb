Cats99::Application.routes.draw do
  resources :cats
  resources :cat_rental_requests, except: :show

  root to: 'cats#index'
end
