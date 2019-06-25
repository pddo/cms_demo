# typed: strict
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :admin_session #, only: [:create]
  get "login", to: "admin_sessions#new"
  get "logout", to: "admin_sessions#destroy"
  delete "logout", to: "admin_sessions#destroy"

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
