Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    get 'projects', to: 'projects#index'
    get 'scrap_data', to: 'projects#scrap_data'
  end

  get '*page', to: "static#index", constraints: ->(req) do
    !req.xhr? && req.format.html?
  end

  root to: "static#index"
end
