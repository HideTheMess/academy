GistClone::Application.routes.draw do
  resources :users, :only => [:create, :new]
  resource :session, :only => [:create, :destroy, :new]
  resources :gists, only: [:index] do
    resource :favorite, only: [:create, :destroy]
  end
  resource :root, only: [:root]
  resources :favorites, only: [:index]

  root :to => "root#root"
end
