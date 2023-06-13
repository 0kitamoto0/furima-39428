class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?


  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :password, :password_confirmation, :last_name, :first_name, :last_name_kana, :first_name_kana, :date_of_birth])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def after_sign_up_path_for(resource)
    if resource.is_a?(User) && resource.valid?
      # 登録が成功した場合のリダイレクト先
      root_path
    else
      # 登録が失敗した場合のリダイレクト先
      flash[:alert] = resource.errors.full_messages.join(", ")
      new_user_registration_path
    end
  end
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.valid?
      # ログインが成功した場合のリダイレクト先
      root_path
    else
      # ログインが失敗した場合のリダイレクト先
      flash[:alert] = "ログインに失敗しました。"
      user_session_path
    end
  end
end