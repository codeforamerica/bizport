Rails.application.routes.draw do

  get '/users/edit' => 'users#edit'
  get '/profile' => 'users#profile'
  put '/profile' => 'users#update'

  devise_for :users, controllers: {
    passwords: 'users/passwords'
  }


  ActiveAdmin.routes(self)
  root 'static#home'

  get '/apply/:page', to: redirect('/launch/%{page}')
  get '/survey' => 'static#survey'

  get '/checklist', to: redirect('/profile')
  patch '/checklist' => 'checklists#update'

  resources :subscriptions, only: [:create]

  get '/resources', to: redirect('/resources/search')
  get '/resources/search' => 'resources#new'
  post '/resources/search' => 'resources#search'
  get '/resources/search/:id' => 'resources#results'
  get '/resources/:id' => 'resources#show'

  get '/reports/user_count'

  get '/grow/obtain-funding', to: redirect('/resources/search') # covers a CMS route
  comfy_route :cms_admin, path: '/cms'
  comfy_route :cms, path: '/', sitemap: false # Make sure this routeset is defined last
end
