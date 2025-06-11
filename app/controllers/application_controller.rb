class ApplicationController < ActionController::Base
  # ログアウト後の遷移先をトップページに設定
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  # 本番環境のみベーシック認証を実施
  before_action :basic_auth, if: :production_env?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |user, password|
      user == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def production_env?
    Rails.env.production?
  end
end