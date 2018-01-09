Rails.application.routes.draw do
  devise_for :users, controllers: { passwords: 'users/passwords' }

  resources :domains, only: %i[index show]
  resources :competitors

  root to: 'domains#index'
end
