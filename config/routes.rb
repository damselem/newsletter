Newsletter::Application.routes.draw do
  resources :posts, :only => [:index, :create] do
    get :week,    :on => :collection
    get :archive, :on => :member
  end

  resources :users, :only => [:index, :show]

  get 'auth/:provider/callback', :to => 'sessions#create'
  get 'login', :as => :login,    :to => 'sessions#new'

  root :to => 'posts#week'
end
