Rails.application.routes.draw do
  root "home#index"

  resources :recipes
  get 'search', to: 'recipes#search'
end
