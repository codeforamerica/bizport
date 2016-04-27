Rails.application.routes.draw do

  root 'static#home'

  get '/survey' => 'static#survey'
  get '/contact' => 'static#contact'
  get '/checklist' => 'static#checklist'
  resources :subscriptions, only: [:create]

  get '/resources' => 'static#resources'

  comfy_route :cms_admin, :path => '/admin'
  comfy_route :cms, :path => '/', :sitemap => false # Make sure this routeset is defined last

end
