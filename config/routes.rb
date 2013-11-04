Bloccit::Application.routes.draw do
  
  resources :posts

  match "about" => "welcome#index", via: :get

  root to: 'welcome#index'
  
end
