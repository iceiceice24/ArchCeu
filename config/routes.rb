Rails.application.routes.draw do
  root 'folders#index'
  devise_for :users 
  resources :folders

  resources :users do
    resources :folders do
      resources :subfolders, controller: 'folders', only: [:new, :create]    
    end
  end
  

  get '/search_folders', to: 'folders#search', as: 'search_folders'
  get 'folders/back'

  
  delete "attachments/:id/purge", to: "attachments#purge", as: "purge_attachment"
end
