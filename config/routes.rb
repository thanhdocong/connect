Rails.application.routes.draw do
  
  #get 'home_pages/home'
  root 'home_pages#home'
  #get 'home_pages/help'
  get 'help'    => 'home_pages#help'
  #get 'home_pages/about'
  get 'about'   => 'home_pages#about'
  #get 'home_pages/contact'
  get 'all_entries'   => 'home_pages#all_entries'
  #get 'home_pages/contact'
  get 'contact' => 'home_pages#contact'
  #get 'users/new'
  get 'signup' =>'users#new'
  
  #get 'sessions/new'
  get 'signin' =>'sessions#new'
  post 'signin'=>'sessions#create'
  delete 'signout'=>'sessions#destroy'
  #get all resources users have index, show, new, create, edit, update,destroy
  resources :users
  resources :entries#,          only: [:create, :destroy]
  resources :comments,          only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end 
 resources :relationships, only: [:create, :destroy]
end
