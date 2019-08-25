Rails.application.routes.draw do
  get 'sessions/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'
  root 'sessions#new'

  get '/login', to: 'session#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/search' => 'users#search', :as => 'search_page'

  resources :users

  resources :posts do
    member do
      put "like" => "posts#like"
      # put "unlike" => "posts#unlike"
    end
  end
end
