Rails.application.routes.draw do
  root to: 'posts#index'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :users, only:[:show, :edit, :update]
  resources :posts do
    resources :comments, only:[:create]
    collection do
      get 'search'
    end
  end
end
