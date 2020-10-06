Rails.application.routes.draw do
  root to: 'posts#index'
  get '/users', to: redirect("/users/sign_up")
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :users, only:[:show, :edit, :update]
  resources :posts do
    resources :comments, only:[:create]
    collection do
      get 'search'
    end
  end

  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'

end
