class InvitesController < ApplicationController
  def new; end

  def create
    handle = params[:github_handle]
    token = current_user.token

    new_invite = InviteSearch.new(handle, token)

    email = new_invite.invitee_email
    name = new_invite.invitee_name
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
