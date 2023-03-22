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
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
