# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token, only: :github

    def github
      # ユーザー情報を取得
      @user = User.from_omniauth(request.env['omniauth.auth'])

      # ユーザーを検索または作成
      if @user.persisted?
        # @user.skip_confirmation! if @user.respond_to?(:skip_confirmation!)
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
      else
        logger.debug 'githubでユーザー検索or作成できませんでした...'
        session['devise.github_data'] = request.env['omniauth.auth'].except(:extra)
        redirect_to new_user_registration_url # 登録ページに遷移
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
