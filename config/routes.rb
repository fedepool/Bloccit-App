Bloccit::Application.routes.draw do
  get "demo/index"

  get "welcome/index"

  get "welcome/about"

  root to: 'welcome#index'
  
end
