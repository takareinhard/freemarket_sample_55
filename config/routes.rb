Rails.application.routes.draw do
  root to: "categories#index"
  resources :categories

  get "registration" => 'categories#registration'
  get "sms_authentication" => 'categories#sms_authentication'
  get "profile" => 'categories#profile'
  get "payment" => 'categories#payment'
  get "member_finish" => 'categories#member_finish'

end