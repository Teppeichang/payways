Rails.application.routes.draw do
  root to: 'posts#index'
  get '/users', to: redirect("/users/sign_up")
  devise_for :users, controllers: {registrations: 'users/registrations'}
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  resources :users, only:[:show, :edit, :update]
  resources :posts do
    resources :comments, only:[:create, :destroy]
    collection do
      get 'search'
    end
  end

  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  get 'like/index' => 'likes#index', as: 'like_index'
  
end
