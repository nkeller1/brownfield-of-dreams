Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only: %i[show index destroy]
      resources :videos, only: [:show]
    end
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'
  get '/:token/confirm_email/', to: 'users#confirm_email', as: 'confirm_email'

  post '/invite', to: 'invites#create'
  get '/invite', to: 'invites#new'

  post '/friendship', to: 'friendships#create'

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    resources :tutorials, only: %i[create edit update destroy new show] do
      resources :videos, only: [:create]
    end
    resources :videos, only: %i[edit update destroy]

    namespace :api do
      namespace :v1 do
        put 'tutorial_sequencer/:tutorial_id', to: 'tutorial_sequencer#update'
      end
    end
  end

  get '/auth/:provider/callback', to: 'oauth#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'users#show'
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'

  # Is this being used?
  get '/video', to: 'video#show'

  resources :users, only: %i[new create update edit]

  resources :tutorials, only: %i[show index] do
    resources :videos, only: %i[show index]
  end

  resources :user_videos, only: %i[create destroy]
end
