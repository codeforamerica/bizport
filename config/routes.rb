Rails.application.routes.draw do
  devise_for :users, controllers: {
    passwords: 'users/passwords'
  }

  get '/dashboard' => 'users#edit'
  put '/dashboard' => 'users#update'

  ActiveAdmin.routes(self)
  root 'static#home'

  get '/survey' => 'static#survey'
  get '/contact' => 'static#contact'

  resource :checklist, only: [:show, :update]

  resources :subscriptions, only: [:create]

  get '/resources', to: redirect('/resources/search')
  get '/resources/search' => 'resources#new'
  post '/resources/search' => 'resources#search'
  get '/resources/search/:id' => 'resources#results'
  get '/resources/:id' => 'resources#show'

  get '/grow/obtain-funding', to: redirect('/resources/search') # covers a CMS route
  comfy_route :cms_admin, path: '/cms'
  comfy_route :cms, path: '/', sitemap: false # Make sure this routeset is defined last
end
