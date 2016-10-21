Rails.application.routes.draw do
  get '/users/edit' => 'users#edit'
  get '/profile' => 'users#profile'
  put '/profile' => 'users#update'
  put '/profile/update' => 'users#profile_update'

  devise_for :users, controllers: {
    passwords: 'users/passwords'
  }

  ActiveAdmin.routes(self)
  root 'static#home'
  get '/survey' => 'static#survey'

  # redirect all 'apply' pages (old name) to matching 'launch' pages
  get '/apply/:page', to: redirect('/launch/%{page}')

  # redirect from original home of 'checklist' page to new 'profile' page
  get '/checklist', to: redirect('/profile')

  patch '/checklist' => 'checklists#update'
  put '/checklist' => 'checklists#update_item'

  get '/resources', to: redirect('/resources/search')
  get '/resources/search' => 'resources#new'
  post '/resources/search' => 'resources#search'
  get '/resources/search/:id' => 'resources#results'
  get '/resources/:id' => 'resources#show'

  get '/reports/user_count'

  # must come before CMS - covers a CMS route, redirecting to Resource Matching
  get '/grow/obtain-funding', to: redirect('/resources/search')

  comfy_route :cms_admin, path: '/cms'
  comfy_route :cms, path: '/', sitemap: false # Make sure this routeset is defined last
end
