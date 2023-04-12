Rails.application.routes.draw do

  devise_for :users 
  resources :folders
  root 'folders#home'
  get '/alluser', to: 'folders#alluser', as: :alluser

  resources :users do
    resources :folders, only: [:index, :new, :create]
      resources :subfolders, controller: 'folders', only: [:new, :create]
    
  end
  namespace :admin do
    resources :users, only: [:index,:edit, :update] do
    delete 'delete_user', on: :member
  end
  end
  
  

  get '/search_folders', to: 'folders#search', as: 'search_folders'
  get 'folders/back'

  
  delete "attachments/:id/purge", to: "attachments#purge", as: "purge_attachment"
end
