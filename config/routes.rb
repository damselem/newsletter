Newsletter::Application.routes.draw do
  resources :posts, :only => [:index, :create, :show] do
    get :archive, :on => :member
  end

  resources :users, :only => [:index, :show]

  get 'auth/:provider/callback', :to => 'sessions#create'
  get 'login', :as => :login,    :to => 'sessions#new'

  root :to => 'posts#index'
end
