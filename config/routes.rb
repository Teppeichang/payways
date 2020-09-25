Rails.application.routes.draw do
  root to: 'posts#index'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :users
  resources :posts do
    collection do
      get 'search'
    end
  end
end
