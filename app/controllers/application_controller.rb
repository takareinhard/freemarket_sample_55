class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [profile_attributes: [:nickname, :last_name, :first_name, :first_name_kana, :last_name_kana, :birthday] ])
  end

  def after_sign_in_path_for(resource)
    if current_user
      flash[:notice] = "ログインに成功しました" 
      root_url
    else
      flash[:notice] = "新規登録完了しました。次に電話番号を入力してください" 
      sms_authentication
    end
  end

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end