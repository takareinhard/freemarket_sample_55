class SignupController < ApplicationController
  before_action :redirect_to_index_from_sms,only: :sms_authentication

  def index
    @user = User.new
    @profile = Profile.new
  end

  def first_validation
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:nickname] = profile_params[:nickname]
    session[:last_name] = profile_params[:last_name]
    session[:first_name] = profile_params[:first_name]
    session[:last_name_kana] = profile_params[:last_name_kana]
    session[:first_name_kana] = profile_params[:last_name_kana]
    session[:birthday] = Date.new(profile_params["birthday(1i)"].to_i,profile_params["birthday(2i)"].to_i,profile_params["birthday(3i)"].to_i)
    @user = User.new(
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
    )
    @profile = Profile.new(
      user: @user,
      nickname: session[:nickname],
      birthday: session[:birthday],
      last_name: session[:last_name],
      first_name: session[:first_name],
      first_name_kana: session[:first_name_kana],
      last_name_kana: session[:last_name_kana],
      prefecture: '沖縄',
      city: '那覇市',
      house_number: 'テスト',
      # post_number: 808-0001,
      building_name: '須崎ビル',
    )

    check_user_valid = @user.valid?
    check_profile_valid = @profile.valid?
    # reCAPTCHA（私はロボットではありませんのアレ）とユーザー、プロフィールのバリデーション判定
    unless verify_recaptcha(model: @profile) && check_user_valid && check_profile_valid
      render 'signup/registration' 
    else
      # 問題がなければsession[:through_first_valid]を宣言して次のページへリダイレクト
      session[:through_first_valid] = "through_first_valid"
      redirect_to sms_authentication_signup_index_path
  end
end

  def second_validation
    session[:post_number] = profile_params[:post_number]
    session[:prefecture] = profile_params[:prefecture]
    session[:city] = profile_params[:city]
    session[:house_number] = profile_params[:house_number]
    session[:building_name] = profile_params[:building_name]
    session[:tel_number] = profile_params[:tel_number]
    @user = User.new(
      email: 'hoge@gmail.com',
      password: '1234hvx7',
      password_confirmation: '1234hvx7',
    )
    @profile = Profile.new(
      user: @user,
      birthday:  '19861120',
      last_name:  '廣田',
      first_name:  '正春',
      first_name_kana:  'マサハル',
      last_name_kana:  'ヒロタ',
      prefecture: session[:prefecture],
      city: session[:city],
      house_number: session[:house_number],
      post_number: session[:post_number],
    )
      check_user_valid = @user.valid?
      check_profile_valid = @profile.valid?
      session[:through_second_valid] = "through_second_valid"
      redirect_to credit_card_signup_index_path
  end

  def sms_authentication
    @user = User.new
    @profile = Profile.new
    @user.build_profile
  end

  def sms_confirmation
    @user = User.new
    @profile = Profile.new
    @user.build_profile
  end

  def address
    @user = User.new
    @profile = Profile.new
    @user.build_profile
  end

  def registration
    @user = User.new
    @profile = Profile.new
    @user.build_profile
  end

  def create
    @user = User.new(
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      )
    # 万一ユーザーがcreateできなかった場合、全sessionをリセットして登録ページトップへリダイレクト
    unless @user.save
      reset_session
      redirect_to signup_index_path
      return
    end

    @profile = Profile.create(
      user: @user,
      nickname: session[:nickname],
      birthday: session[:birthday],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      prefecture: session[:prefecture],
      city: session[:city],
      house_number: session[:house_number],
      post_number: session[:post_number],
      tel_number: session[:tel_number],
      building_name: session[:building_name],
    )

  # 最後のフォームでクレジット認証を行なっているため、ここでカードの顧客情報を作り、userと紐づけてDBに保存する処理を行なっています
  binding.pry
  Payjp.api_key = "sk_test_88a4b35f1038b2298666f28f"
  customer = Payjp::Customer.create(card: params[:payjp_token])
  @credit_card = CreditCard.new(user: @user, customer_id: customer.id)
  # カード情報まで保存に成功したら全sessionをリセットしてユーザーidのみsessionに預け、完了画面へリダイレクト
  if @credit_card.save
    reset_session
    session[:id] = @user.id
    redirect_to done_signup_index_path
    return 
  else
    #失敗したらsessionを切って登録ページトップへリダイレクト
    reset_session
    redirect_to signup_index_path
  end
end

  # 図⑥のアクション
  def done
    # session[id]がなければ登録ページトップへリダイレクト
    unless session[:id]
      redirect_to signup_index_path 
      return
    end
    # deviseのメソッドを使ってログイン
    sign_in User.find(session[:id])
  end

  def sms_post
    @profile = Profile.new
    #パラメータが飛んでなかった場合ここでrender
    render sms_authentication_signup_index_path unless  profile_params[:tel_number].present?
    #電話番号を+81~の国際書式に書き換え（そうしないと送れない）
    phone_number = profile_params[:tel_number].sub(/\A./,'+81')
    #ランダムに5桁の整数を生成
    sms_number = rand(10000..99999)
    #後の認証用にsessionに預ける
    session[:sms_number] = sms_number
    #環境変数を使ってsms送信準備 
    client = Twilio::REST::Client.new(ENV["TWILLIO_SID"],ENV["TWILLIO_TOKEN"])
    #送信失敗した場合必ずエラーが出るので、例外処理で挙動を分岐
    begin 
      #生成した整数を文章にしたsms送信
      client.api.account.messages.create(from: ENV["TWILLIO_NUMBER"], to: phone_number, body: sms_number)
    rescue
      #失敗した場合ここが動く。失敗しているのでここをsms_authenticationからadressに変更
      render "signup/authentication/"
      return false
    end
    #成功した場合、以下のコードが動き、smsの照合画面へと変遷する
    redirect_to sms_confirmation_signup_index_path
  end

  def sms_check
    @profile = Profile.new
    #送信された値を代入
    sms_number = profile_params[:tel_number]
    #比較し、一致したら次の登録フォームへ
    if sms_number.to_i == session[:sms_number]
      redirect_to address_signup_index_path
    else
      render "signup/sms_confirmation"
    end
  end

  def customize_sign_up_params
    devise_parameter_sanitizer.permit :sign_up, keys: [:username, :email, :password, :password_confirmation, :remember_me]
  end


  #中略
  private

   #userとprofileのストロングパラメータ
  def user_params
    params.require(:user).permit(:email,:password,:password_confirmation,:card_token,profile_attributes: [:post_number,:house_number,:building_name,:nickname,:birthyear,:birthmonth,:birthday,:last_name,:first_name,:last_name_kana,:first_name_kana,:post_number,:prefecture,:city,:address,:building,:tel_number])
  end

  def profile_params
    params.require(:profile).permit(:post_number,:house_number,:building_name,:nickname,:birthday,:last_name,:first_name,:last_name_kana,:first_name_kana,:post_number,:prefecture,:city,:address,:tel_number)
  end

  def credit_card_params
    params.require(:credit_card).permit(:user_id,:customer_id,:card_id)
  end

   # 前のpostアクションで定義されたsessionがなかった場合登録ページトップへリダイレクト
  def redirect_to_index_from_sms
    redirect_to signup_index_path unless session[:through_first_valid].present? && session[:through_first_valid] == "through_first_valid"
  end

  def redirect_to_index_from_credit_card
    redirect_to credit_card_index_path unless session[:through_second_valid].present? && session[:through_second_valid] == "through_second_valid"
  end

# def profile_params
#   params.require(:profile).permit(
#     :nickname, 
#     :first_name, 
#     :last_name, 
#     :first_name_kana, 
#     :last_name_kana, 
#     :post_number,
#     :prefecture,
#     :city,
#     :house_number,
#     :building_name,
#     :birthday,
#     :tel_number,

#   )
# end

end
