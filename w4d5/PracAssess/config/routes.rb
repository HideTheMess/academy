PracAssess::Application.routes.draw do
  resources :users
  resource :session, :only => [:new, :create, :destroy]
  resource :following, :only => [:index]
end
