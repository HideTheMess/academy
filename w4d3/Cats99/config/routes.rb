Cats99::Application.routes.draw do
  resources :cats

  root to: 'cats#index'
end
