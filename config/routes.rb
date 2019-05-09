Rails.application.routes.draw do
  devise_for :user, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', passwords: 'users/passwords' }

  get 'p/:page', to: 'pages#show', as: :page
  root to: 'pages#show', page: 'ganhador'
  resources :coupons, only: [:index] do
    post 'sync', on: :collection
  end
end
