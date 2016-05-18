Rails.application.routes.draw do


  devise_for :users, :controllers => { :invitations => 'users/invitations', :confirmations => 'confirmations' }

  resources :users, only: [:index]


  authenticated :user do
    root 'posts#index', as: :authenticated_root
  end

  root 'home#index'
  get 'home/thankyou'

  resources :posts do
    member do
      put "upvote" => "posts#upvote"
      put "downvote" => "posts#downvote"
    end
  end

  resources :tags, only: [:index, :show]

  resources :comments

  resources :keep_posts, only: [:create, :destroy]

  resources :keep_events, only: [:create, :destroy]

  resources :requests, only: [:create]

  resources :events


  get 'mind', to: 'keep_posts#index'
  get ':id' => 'users#show', as: :user_profile
  get ':id/settings' => 'users#edit', as: :user_settings
  match ':id/settings' => 'users#update', via: [:put, :patch]

end
