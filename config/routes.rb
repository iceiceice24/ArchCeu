Rails.application.routes.draw do
  resources :folders do
    resources :subfolders, controller: 'folders', only: [:new, :create]
  end
  resources :folders
  root 'folders#index'

  get '/search_folders', to: 'folders#search', as: 'search_folders'

  
  delete "attachments/:id/purge", to: "attachments#purge", as: "purge_attachment"
  
end
