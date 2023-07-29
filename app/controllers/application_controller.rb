class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # ログイン済ユーザーのみにアクセスを許可
  before_action :authenticate_user!, except: [:top, :about]

  # devise利用時の機能でユーザ登録・ログイン認証が使われる前にconfigure_permitted_parametersメソッドを実行する処理
	before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource) #ログイン後マイページへ
    user_path(@user.id)
  end

  def after_sign_out_path_for(resource) #ログアウト後トップページへ
    root_path
  end

  protected

  def configure_permitted_parameters
    # configure_permitted_parametersは、devise_parameter_sanitizer.permitを使うことでsign_upの際に、emailのデータ操作を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  # 編集画面から画像を受け取れるよう設定
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:account_update, keys: %i(avatar))
  # end

end
