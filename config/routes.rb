Rails.application.routes.draw do
  get 'folders/index'
  get 'folders/show'
  get 'folders/new'
  get 'folders/create'
  get 'folders/edit'
  get 'folders/update'
  get 'folders/destroy'
  resources :folders
  root 'folders#index'

  get '/search_folders', to: 'folders#search', as: 'search_folders'

  
  delete "attachments/:id/purge", to: "attachments#purge", as: "purge_attachment"
  
end
