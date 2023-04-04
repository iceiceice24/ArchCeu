Rails.application.routes.draw do

  devise_for :users do
    resources :folders do
      resources :subfolders, controller: 'folders', only: [:new, :create]
    end
  end
  
  resources :folders
  root 'folders#index'

  get '/search_folders', to: 'folders#search', as: 'search_folders'
  get 'folders/back'

  
  delete "attachments/:id/purge", to: "attachments#purge", as: "purge_attachment"
end
