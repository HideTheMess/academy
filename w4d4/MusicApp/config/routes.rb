MusicApp::Application.routes.draw do
  resources :bands do
    resources :albums, only: [:index] do
      resources :tracks, only: [:index]
    end
  end

  resources :albums, except: [:index]
  resources :tracks, except: [:index]
  resources :notes, only: [:create, :destroy]

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
end
