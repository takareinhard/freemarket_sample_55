Rails.application.routes.draw do

  root to: "products#index"
  resources :products
  

  # devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  root to: "categories#index"
  resources :categories

  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end

  resources :products, only: [:new, :create] do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_size', defaults: { format: 'json' }
      get 'get_delivery'
    end
  end


  #新規会員登録のページ達
  get "member_information_input" => 'categories#member_information_input' #会員情報入力
  get "sms_authentication" => 'users#sms_authentication' #電話番号認証
  get "profile" => 'categories#profile' #お届け先住所入力
  get "payment" => 'categories#payment' #支払い方法
  get "member_finish" => 'categories#member_finish' #完了
  resources :categories, only:[:show, :index] do
    collection do
    end
  end

  # resources :card, only: [:new, :show] do
  #   collection do
  #     post 'show', to: 'card#show'
  #     post 'pay', to: 'card#pay'
  #     post 'delete', to: 'card#delete'
  #   end
  # end
  

  #ログインページ
  get "old_member_registration" => 'categories#old_member_registration' #既存メンバーのログインページ

  #マイページ
  get "mypage" => 'categories#mypage' #マイページ

  #ユーザープロフィール編集ページ
  get "edit_profile" => 'categories#edit_profile' #ユーザープロフィール編集ページ

  #ユーザーログアウトページ
  get "logout" => 'categories#logout' #ユーザーログアウトページ

  #ユーザー本人確認ページ
  get "identification" => 'categories#identification' #ユーザー本人確認ページ

  #商品購入確認ページ
  get "product_purchase_confirmation" => 'products#product_purchase_confirmation' #商品購入確認ページ

  #ユーザークレジットカード登録ページ
  get "user_credit_registration" => 'categories#user_credit_registration' #ユーザークレジットカード登録ページ

  #商品詳細ページ
  get "product_detail" => 'products#product_detail'
end