Rails.application.routes.draw do
  resources :projects, only: :index

  get 'scrap_data', to: 'projects#scrap_data'

  root to: "projects#index"
end
