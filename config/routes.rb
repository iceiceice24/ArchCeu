Rails.application.routes.draw do
  resources :folders do
    resources :subfolders, controller: 'folders', only: [:new, :create]
  end
  resources :folders
  root 'folders#index'

  get '/search_folders', to: 'folders#search', as: 'search_folders'
  get 'folders/back'

  
  delete "attachments/:id/purge", to: "attachments#purge", as: "purge_attachment"
  
  # get 'folders/:parent_id/:id', to: 'folders#host', as: 'find_folder'
end
