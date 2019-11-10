Rails.application.routes.draw do

  root to: "products#index"
  resources :products
  
  # devise_for :users, controllers: { registrations: 'users/registrations' }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :signup ,only: [:index,:create] do
    collection do
      get 'registration'                               # 図①  
      post 'registration' => 'signup#first_validation' # 図❶
      #中略
      #電話番号入力フォーム
      get 'sms_authentication' 
      #入力された番号へのSMS送信、送信した文字列の保持
      post 'sms_authentication' => 'signup#sms_post'
      #受信した値の入力フォーム
      get 'sms_confirmation' 
      #値の照合
      post 'sms_confirmation' => 'signup#sms_check'
      #一致したら下のパスに飛んで登録画面が続く
      get 'address'                                    # 図④
      post 'address' => 'signup#second_validation'     # 図❹
      get 'credit_card'
      post 'credit_card' => 'signup#create' 
      get 'done'                                       # 図⑥
    end
  end

  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end

  resources :products, only: [:new, :create, :index] do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_size', defaults: { format: 'json' }
      get 'get_delivery'
    end
  end

  resources :categories, only:[:show, :index] do
    collection do
    end
  end

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