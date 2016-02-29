Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'static#home'

  namespace :start do
    get 'business-plan' => '/static#business_plan'
    get 'finance-your-business' => '/static#finance_your_business'
    get 'find-a-location' => '/static#find_a_location'
    get 'choose-a-name' => '/static#choose_a_name'
    get 'register-your-business' => '/static#register_your_business'
  end

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
