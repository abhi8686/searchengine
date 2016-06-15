Rails.application.routes.draw do
  root to: 'home#index', as: :home
  get 'home/index'
  post 'home/search'
end