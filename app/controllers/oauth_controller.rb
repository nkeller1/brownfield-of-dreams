class OauthController < ApplicationController
  def create
    # require "pry"; binding.pry
    current_user.update(token: request.env['omniauth.auth']['credentials']['token'])

    redirect_to dashboard_path, notice: "Connected to Github!"
  end
end
