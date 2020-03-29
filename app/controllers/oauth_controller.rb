class OauthController < ApplicationController
  def create
    token = request.env['omniauth.auth']['credentials']['token']
    current_user.update(token: token)

    redirect_to dashboard_path, notice: 'Connected to Github!'
  end
end
