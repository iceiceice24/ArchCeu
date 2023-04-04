Rails.application.routes.draw do

  devise_for :users 
  resources :users do
    resources :folders, only: [:index, :new, :create]
      resources :subfolders, controller: 'folders', only: [:new, :create]
    
  end
  
  resources :folders
  root 'folders#index'

  get '/search_folders', to: 'folders#search', as: 'search_folders'
  get 'folders/back'

  
  delete "attachments/:id/purge", to: "attachments#purge", as: "purge_attachment"
end
