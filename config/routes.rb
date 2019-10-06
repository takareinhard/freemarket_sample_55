Rails.application.routes.draw do
  root to: "categories#index"
  resources :categories

  get "user" => 'categories#user'
  get "sms_authentication" => 'categories#sms_authentication'
  get "profile" => 'categories#profile'
  get "payment" => 'categories#payment'

end