Bloccit::Application.routes.draw do
  
  resources :post 

  match "about" => "welcome#index", via: :get

  root to: 'welcome#index'
  
end
