Rails.application.routes.draw do
  root to: "categories#index"
  resources :categories

  get "sms_confirmation" => 'categories#sms_confirmation'

end