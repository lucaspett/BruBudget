Rails.application.routes.draw do
  devise_for :users
  resources :expenditures
  root 'expenditures#index'
end
