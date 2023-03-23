Rails.application.routes.draw do
  get 'folders/index'
  get 'folders/show'
  get 'folders/new'
  get 'folders/create'
  get 'folders/edit'
  get 'folders/update'
  get 'folders/destroy'
  resources :folders

  get '/search_folders', to: 'folders#search', as: 'search_folders'

  
  resources :folders do
    member do
      delete :folder_file
    end
  end
  
end
