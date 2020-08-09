Rails.application.routes.draw do
  #get 'users/show'
  root :to => 'homes#index'
  #root ''#ログイン・サインイン後にトップページに行くように設定
  devise_for :users
  resources :users 
  get '/home/about', to: 'homes#about'
  resources :books do
  	resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
