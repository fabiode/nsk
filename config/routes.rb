Rails.application.routes.draw do
  devise_for :user, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  root to: 'coupons#index'

  get 'p/:page', to: 'pages#show', as: :page
  resources :coupons, only: [:index] do
    post 'sync', on: :collection
  end
end
