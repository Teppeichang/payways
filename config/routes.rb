Rails.application.routes.draw do
  root to: 'homes#index'

  # タグにリンク付けし、同じタグを持つ投稿が一覧表示されるよう設定
  get 'tags/:tag', to: 'posts#index', as: :tag
  
  get '/users', to: redirect("/users/sign_up")
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :relationships, only:[:create, :destroy]
  
  resources :posts do
    resources :comments, only:[:create, :destroy]
    collection do
      get 'search'
    end
  end

  # いいね機能に関するルーティング
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  get 'like/index' => 'likes#index', as: 'like_index'

  # 通知機能に関するルーティング
  resources :notifications, only:[:index, :destroy]

end
