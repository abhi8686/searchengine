Rails.application.routes.draw do
  get 'checker/index'

  root to: 'home#index', as: :home
  get 'home/index'
  post 'home/search'
end