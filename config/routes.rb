Rails.application.routes.draw do
  root to: "categories#index"
  resources :categories

  #新規会員登録のページ達
  get "member_information_input" => 'categories#member_information_input' #会員情報入力
  get "sms_authentication" => 'categories#sms_authentication' #電話番号認証
  get "profile" => 'categories#profile' #お届け先住所入力
  get "payment" => 'categories#payment' #支払い方法
  get "member_finish" => 'categories#member_finish' #完了

  #ログインページ
  get "new_member_registration" => 'categories#new_member_registration' #新規会員登録ログインページ
  get "old_member_registration" => 'categories#old_member_registration' #既存メンバーのログインページ

  #マイページ
  get "mypage" => 'categories#mypage' #マイページ"

  #ユーザープロフィール編集ページ
  get "edit_profile" => 'categories#edit_profile' #ユーザープロフィール編集ページ"

end