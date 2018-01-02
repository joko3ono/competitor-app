Rails.application.routes.draw do
  devise_for :users, controllers: { passwords: 'users/passwords' }
  resources :domain, except: %i[show]

  root to: 'domain#index'
end
