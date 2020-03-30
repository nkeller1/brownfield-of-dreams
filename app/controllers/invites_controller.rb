class InvitesController < ApplicationController
  def new
  end

  def create
    response = Faraday.get("https://api.github.com/users/#{params['github_handle']}?access_token=#{current_user.token}")
    user_json = JSON.parse(response.body, symbolize_names: true)
    
    email = user_json[:email]
    name = user_json[:name]
    inviter = current_user.username

    if email.nil?
      flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
    else
      InviteMailer.invite(name, email, inviter).deliver_now
      flash[:success] = 'Successfully sent invite!'
    end

    redirect_to dashboard_path
  end
end
