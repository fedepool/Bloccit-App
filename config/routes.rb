Bloccit::Application.routes.draw do
  
  devise_for :users

  resources :posts

  match "about" => "welcome#index", via: :get

  root to: 'welcome#index'
  
end
